// Copyright (C) 2020 Andrew Lord

import Foundation
import ShellOut

struct ShellError: Error, CustomStringConvertible {
    var description: String {
        "Failed when running shell command"
    }
}

func runShell(_ command: String, continueOnError: Bool = false) throws {
    do {
        try shellOut(
            to: command,
            outputHandle: .standardOutput,
            errorHandle: .standardError
        )
    } catch {
        if !continueOnError {
            throw ShellError()
        }
    }
}
