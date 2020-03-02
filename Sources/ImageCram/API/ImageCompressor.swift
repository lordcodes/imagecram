// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

public struct ImageCompressor {
    private let apiKey: String
    private let parser: FileParser
    private let dispatchGroup = DispatchGroup()

    public init(apiKey: String) {
        self.init(apiKey: apiKey, parser: FileParser())
    }

    init(apiKey: String, parser: FileParser) {
        self.apiKey = apiKey
        self.parser = parser
    }

    public func compress(filePaths paths: [String]) throws {
        let files = try parser.parse(filePaths: paths)

        try files.forEach { file in
            try compress(file: file)
        }
    }

    private func compress(file: File) throws {
        dispatchGroup.enter()
        let token = "api:\(apiKey)".data(using: .utf8)!
        let authorization = "Basic \(token.base64EncodedString())"
        let headers = [
            "authorization": authorization,
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        var request = URLRequest(url: URL(string: "https://api.tinify.com/shrink")!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 90.0)

        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        let fileUrl = file.url
        let uploadTask = URLSession.shared.uploadTask(with: request, fromFile: fileUrl) { (data, response, error) in
            if let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 201 {
                print("Uploaded successfully")
                print("Download from: \(httpRes.allHeaderFields["Location"])")
            } else if let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 401 {
    //                self.error = NSError(domain: "Unauthorized", code: 401, userInfo: nil)
                // TODO: Handle unauthorized error
                print("Unauthorized")
            } else if let error = error {
                // TODO: Handle other errors
                print("Error occurred: \(error)")
            } else {
                print("Upload finished")
            }
            self.dispatchGroup.leave()
        }
        uploadTask.resume()
        dispatchGroup.wait()
    }
}
