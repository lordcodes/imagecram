// Copyright (C) 2020 Andrew Lord

import ArgumentParser
import Files
import Foundation
import ImageCram

struct ImageCramCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "imagecram")

    @Argument(help: "The input image file or directory of images")
    var inputs: [String]

    @Option(name: .shortAndLong, help: "Output file or directyory")
    var output: String?

    @Flag(name: .shortAndLong, help: "Output the version number")
    var version: Bool

    @Flag(name: .shortAndLong, help: "Silence any output except errors")
    var quiet: Bool

    func validate() throws {
        if version {
            return
        }
        if inputs.isEmpty {
            throw ValidationError("Please provide at least 1 input file")
        }
    }

    func run() throws {
        if version {
            print(ImageCramVersion.current)
            return
        }

        print("IN: \(inputs)")
        print("OUT: \(output ?? "")")

        let apiKeyRepository = ApiKeyRepository()
        let apiKey = apiKeyRepository.read()

        guard !apiKey.isEmpty else {
            printError("Missing TinyPNG API key.")
            return
        }

        let compressor = ImageCompressor(apiKey: apiKey)
        try compressor.compress(filePaths: inputs)
    }
}
