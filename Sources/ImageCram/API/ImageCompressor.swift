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

        let uploadTask = UploadTask(apiKey: apiKey)
        let result = uploadTask.upload(file)

        if case let .failure(error) = result {
            throw error
        }
    }
}
