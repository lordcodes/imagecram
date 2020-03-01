// Copyright (C) 2020 Andrew Lord

public struct ImageCompressor {
    private let apiKey: String
    private let parser: FileParser

    public init(apiKey: String) {
        self.init(apiKey: apiKey, parser: FileParser())
    }

    init(apiKey: String, parser: FileParser) {
        self.apiKey = apiKey
        self.parser = parser
    }

    public func compress(filePaths paths: [String]) throws {
        _ = try parser.parse(filePaths: paths)
    }
}
