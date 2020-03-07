// Copyright (C) 2020 Andrew Lord

import Foundation
import ImageCram

struct CommandLinePrinter: ImageCramPrinter {
    let isQuiet: Bool

    func output(message: @autoclosure () -> String) {
        if !isQuiet {
            print(message())
        }
    }

    func forcedOutput(message: String) {
        print(message)
    }

    func output(error: @autoclosure () -> CustomStringConvertible) {
        fputs("\(error())\n", stderr)
    }
}
