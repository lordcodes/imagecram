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

        let printer = CommandLinePrinter(isQuiet: quiet)

        let apiKeyRepository = ApiKeyRepository(printer: printer)
        let apiKey = try apiKeyRepository.read()

        guard !apiKey.isEmpty else {
            printError("Missing TinyPNG API key.")
            return
        }

        let compressor = ImageCompressor(apiKey: apiKey, printer: printer)
        let mover = FileMover(printer: printer, outputPath: output)
        for input in inputs {
            let result = try compressor.compress(filePath: input)
            try mover.move(inputPath: input, from: result.localUrl)
            print("Compressed successfully: \(input)")
        }
    }
}
