// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

public struct ImageCompressor {
    private let apiKey: String
    private let printer: ImageCramPrinter
    private let parser: FileParser

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

        let uploadResult = try upload(file)
        printer.output(message: "Uploaded successfully: \(path)")

        _ = try download(uploadResult.output.url, to: file)
    }

    private func upload(_ file: File) throws -> UploadResult {
        let uploadTask = UploadTask(apiKey: apiKey)
        let result = uploadTask.upload(file)
        switch result {
        case let .success(uploaded):
            return uploaded
        case let .failure(error):
            throw error
        }
    }

    private func download(_ url: URL, to file: File) throws -> Void {
        let downloadTask = DownloadTask(apiKey: apiKey)
        let result = downloadTask.download(url, to: file)
        switch result {
        case let .success(downloaded):
            return downloaded
        case let .failure(error):
            throw error
        }
    }
}
