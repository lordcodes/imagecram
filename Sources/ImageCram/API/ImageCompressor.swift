// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

public struct ImageCompressor {
    private let printer: ImageCramPrinter
    private let parser: FileParser
    private let uploader: Uploader
    private let downloader: Downloader

    public init(apiKey: String, printer: ImageCramPrinter) {
        self.init(
            printer: printer,
            parser: FileParser(),
            uploader: UploadTask(apiKey: apiKey),
            downloader: DownloadTask(apiKey: apiKey)
        )
    }

    init(printer: ImageCramPrinter, parser: FileParser, uploader: Uploader, downloader: Downloader) {
        self.printer = printer
        self.parser = parser
        self.uploader = uploader
        self.downloader = downloader
    }

    public func compress(filePath path: String) throws -> CompressResult {
        let file = try parser.parse(filePath: path)

        let uploadResult = try upload(file)
        printer.output(message: "Uploaded successfully: \(path)")

        let downloadResult = try download(uploadResult.output.url, to: file)
        printer.output(message: "Downloaded successfully for \(file.name)")

        return CompressResult(localUrl: downloadResult.localUrl)
    }

    private func upload(_ file: File) throws -> UploadResult {
        let result = uploader.upload(file)
        switch result {
        case let .success(uploaded):
            return uploaded
        case let .failure(error):
            throw error
        }
    }

    private func download(_ url: URL, to file: File) throws -> DownloadResult {
        let result = downloader.download(url, for: file)
        switch result {
        case let .success(downloaded):
            return downloaded
        case let .failure(error):
            throw error
        }
    }
}
