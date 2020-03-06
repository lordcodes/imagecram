// Copyright (C) 2020 Andrew Lord

import ArgumentParser
import Foundation

struct Tasks: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "tasks",
        abstract: "A task runner for ImageCram, such as linting, testing and other automations.",
        subcommands: [Linting.self, Formatting.self]
    )
}

extension Tasks {
    struct Linting: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "lint",
            abstract: "Run linting on the ImageCram codebase, such as static analysis."
        )

        func run() throws {
            try runShell(command: "swift run swiftformat . --lint")
            try runShell(command: "swift run swiftlint", continueOnError: true)
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
            try runShell(command: "swift run swiftformat .")
            try runShell(command: "swift run swiftlint autocorrect", continueOnError: true)
        }
    }
}

Tasks.main()
