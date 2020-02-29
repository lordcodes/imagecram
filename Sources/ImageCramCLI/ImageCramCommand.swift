// Copyright (C) 2020 Andrew Lord

import ArgumentParser
import Files
import Foundation

struct ImageCramCommand: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Output the version number")
    var version: Bool

    @Option(name: .shortAndLong, help: "Output file or directyory")
    var output: String

    @Flag(name: .shortAndLong, help: "Silence any output except errors")
    var quiet: Bool

    @Argument(help: "The input image file or directory of images")
    var input: String
}
