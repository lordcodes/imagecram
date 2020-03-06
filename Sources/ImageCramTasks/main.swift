// Copyright (C) 2020 Andrew Lord

import ArgumentParser
import Foundation

struct Tasks: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "tasks",
        abstract: "A task runner for ImageCram, such as linting, testing and other automations.",
        subcommands: [Linting.self, Formatting.self, Install.self]
    )
}

extension Tasks {
    struct Linting: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "lint",
            abstract: "Run linting on the ImageCram codebase, such as static analysis."
        )

        func run() throws {
            try runShell(command: "swift run swiftformat . --lint", continueOnError: true)
            try runShell(command: "swift run swiftlint")
        }
    }
}

extension Tasks {
    struct Formatting: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "format",
            abstract: "Run code formatting and auto-correction on the ImageCram codebase."
        )

        func run() throws {
            try runShell(command: "swift run swiftformat .", continueOnError: true)
            try runShell(command: "swift run swiftlint autocorrect")
        }
    }
}

extension Tasks {
    struct Install: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "install",
            abstract: "Build and install ImageCram for running globally."
        )

        func run() throws {
            try runShell(command: "swift build -c release")
            try runShell(command: "install .build/release/imagecram-cli /usr/local/bin/imagecram")
        }
    }
}

Tasks.main()
