// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

struct UploadTask {
    let apiKey: String
    private let dispatchGroup = DispatchGroup()

    func upload(_ file: File) -> Result<UploadResult, ImageCramError> {
        dispatchGroup.enter()

        let request = createUploadRequest()
        let fileUrl = file.url
        var result: Result<UploadResult, ImageCramError>?
        let uploadTask = URLSession.shared.uploadTask(with: request, fromFile: fileUrl) { (data, response, error) in
            result = self.handleUploadResult(file: file, data: data, response: response as? HTTPURLResponse, error: error)
        }
        uploadTask.resume()

        dispatchGroup.wait()
        return result ?? Result.failure(ImageCramError(file, reason: .other("Upload did not complete")))
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
    ) -> Result<UploadResult, ImageCramError> {
        if let response = response, response.statusCode == 201, let data = data {
            return parseResult(for: file, from: data)
        } else if let response = response, response.statusCode >= 400 && response.statusCode < 600, let data = data {
            return parseError(for: file, from: data)
        } else if let response = response, response.statusCode == 401 {
            return uploadResult(Result.failure(ImageCramError(file, reason: .unauthorized)))
        } else if let error = error {
            return uploadResult(Result.failure(ImageCramError(file, reason: .other(error.localizedDescription))))
        }
        return uploadResult(Result.failure(ImageCramError(file, reason: .other("Unexpected"))))
    }

    private func parseResult(for file: File, from data: Data) -> Result<UploadResult, ImageCramError> {
        do {
            return uploadResult(Result.success(try data.decoded()))
        } catch {
            return uploadResult(Result.failure(ImageCramError(file, reason: .uploadFailed(error: error))))
        }
    }

    private func parseError(for file: File, from data: Data) -> Result<UploadResult, ImageCramError> {
        do {
            let apiError = try data.decoded(as: ApiError.self)
            return uploadResult(Result.failure(ImageCramError(file, reason: .uploadFailed(error: apiError))))
        } catch {
            return uploadResult(Result.failure(ImageCramError(file, reason: .uploadFailed(error: error))))
        }
    }

    private func uploadResult(_ result: Result<UploadResult, ImageCramError>) -> Result<UploadResult, ImageCramError> {
        dispatchGroup.leave()
        return result
    }
}
