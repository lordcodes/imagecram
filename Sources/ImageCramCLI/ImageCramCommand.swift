// Copyright (C) 2020 Andrew Lord

import ArgumentParser
import Files
import Foundation
import ImageCram

struct ImageCramCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "imagecram")

    @Argument(help: "One or more input image files")
    var inputs: [String]

    @Option(name: .shortAndLong, help: "Output image file or directory")
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
        if inputs.count > 1, let output = output {
            do {
                _ = try Folder(path: output)
            } catch {
                throw ValidationError("Specified output should be a folder that exists, if multiple input files are provided")
            }
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

        let printer = CommandLinePrinter()
        let compressor = ImageCompressor(apiKey: apiKey, printer: printer)
        for input in inputs {
            let localUrl = try compressor.compress(filePath: input)
            print("Compressed successfully: \(input)")
        }
    }
}
