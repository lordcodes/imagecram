// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

protocol Downloader {
    func download(_ url: URL, for inputFile: File) -> Result<DownloadResult, ImageCramError>
}

struct DownloadTask : Downloader {
    let apiKey: String
    private let dispatchGroup = DispatchGroup()

    func download(_ url: URL, for inputFile: File) -> Result<DownloadResult, ImageCramError> {
        dispatchGroup.enter()

        let request = createDownloadRequest(for: url)
        var result: Result<DownloadResult, ImageCramError>?
        let downloadTask = URLSession.shared.downloadTask(with: request) { (localUrl, response, error) in
            result = self.handleDownloadResult(inputFile: inputFile, localUrl: localUrl, response: response as? HTTPURLResponse, error: error)
        }
        downloadTask.resume()

        dispatchGroup.wait()
        return result ?? Result.failure(ImageCramError(inputFile, reason: .other("Download did not complete")))
    }

    private func createDownloadRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 90.0)
        request.httpMethod = "GET"

        let token = "api:\(apiKey)".data(using: .utf8)!
        let authorization = "Basic \(token.base64EncodedString())"
        request.allHTTPHeaderFields = [
            "authorization": authorization,
            "cache-control": "no-cache"
        ]
        return request
    }

    private func handleDownloadResult(
        inputFile: File,
        localUrl: URL?,
        response: HTTPURLResponse?,
        error: Error?
    ) -> Result<DownloadResult, ImageCramError> {
        if let localUrl = localUrl {
            return downloadResult(Result.success(DownloadResult(localUrl: localUrl)))
        } else if let response = response, response.statusCode == 401 {
           return downloadResult(Result.failure(ImageCramError(inputFile, reason: .unauthorized)))
       } else if let error = error {
           return downloadResult(Result.failure(ImageCramError(inputFile, reason: .other(error.localizedDescription))))
       }
       return downloadResult(Result.failure(ImageCramError(inputFile, reason: .other("Unexpected"))))
    }

    private func downloadResult(_ result: Result<DownloadResult, ImageCramError>) -> Result<DownloadResult, ImageCramError> {
        dispatchGroup.leave()
        return result
    }
}
