// Copyright (C) 2020 Andrew Lord

import Foundation

if StandardInput.hasDataAvailable() {
    let inputs = StandardInput.readLines()
    for filePath in inputs where !FileManager.default.fileExists(atPath: filePath) {
        throw CommandLineError.invalidInputFile(path: filePath)
    }
    ImageCramCommand.main(inputs + Array(CommandLine.arguments.dropFirst()))
} else {
    ImageCramCommand.main()
}
