// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

public struct ImageCompressor {
    private let apiKey: String
    private let printer: ImageCramPrinter
    private let parser: FileParser
    private let dispatchGroup = DispatchGroup()

    public init(apiKey: String, printer: ImageCramPrinter) {
        self.init(apiKey: apiKey, printer: printer, parser: FileParser())
    }

    init(apiKey: String, printer: ImageCramPrinter, parser: FileParser) {
        self.apiKey = apiKey
        self.printer = printer
        self.parser = parser
    }

    public func compress(filePath path: String) throws {
        let file = try parser.parse(filePath: path)
        dispatchGroup.enter()
        let request = createUploadRequest()
        let fileUrl = file.url
        var result: Result<Void, ImageCramError> = Result.success(())
        let uploadTask = URLSession.shared.uploadTask(with: request, fromFile: fileUrl) { (data, response, error) in
            result = self.handleUploadResult(file: file, data: data, response: response as? HTTPURLResponse, error: error)
        }
        uploadTask.resume()
        dispatchGroup.wait()
        switch result {
        case .success:
            self.printer.output(message: "\(file.path) compressed successfully")
        case let .failure(error):
            throw error
        }
    }

    private func createUploadRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.tinify.com/shrink")!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 90.0)
        request.httpMethod = "POST"

        let token = "api:\(apiKey)".data(using: .utf8)!
        let authorization = "Basic \(token.base64EncodedString())"
        request.allHTTPHeaderFields = [
            "authorization": authorization,
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        return request
    }

    private func handleUploadResult(
        file: File,
        data: Data?,
        response: HTTPURLResponse?,
        error: Error?
    ) -> Result<Void, ImageCramError> {
        var result: Result<Void, ImageCramError> = Result.failure(ImageCramError(path: file.path, reason: .other(message: "Unknown")))
        if let response = response, response.statusCode == 201 {
            print("Uploaded successfully")
            print("Download from: \(response.allHeaderFields["Location"])")
            result = Result.success(())
        } else if let response = response, response.statusCode == 401 {
            result = Result.failure(ImageCramError(path: file.path, reason: .unauthorized))
        } else if let error = error {
            print("Error occurred: \(error)")
            result = Result.failure(ImageCramError(path: file.path, reason: .other(message: error.localizedDescription)))
        } else {
            print("Upload finished")
            result = Result.failure(ImageCramError(path: file.path, reason: .other(message: "Unexpected")))
        }
        dispatchGroup.leave()
        return result
    }
}
