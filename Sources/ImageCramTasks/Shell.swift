// Copyright (C) 2020 Andrew Lord

import Foundation
import ShellOut

struct ShellError: Error, CustomStringConvertible {
    var description: String {
        "Failed when running shell command"
    }
}

func runShell(_ command: String, with arguments: [String] = [], continueOnError: Bool = false) throws {
    do {
        try shellOut(
            to: command,
            arguments: arguments,
            outputHandle: .standardOutput,
            errorHandle: .standardError
        )
    } catch {
        if !continueOnError {
            throw ShellError()
        }
    }
}
