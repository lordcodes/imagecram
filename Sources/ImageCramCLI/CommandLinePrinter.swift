// Copyright (C) 2020 Andrew Lord

import Foundation
import ImageCram

struct CommandLinePrinter : ImageCramPrinter {
    func output(message: @autoclosure () -> String) {
        print(message())
    }

    func output(error: @autoclosure () -> CustomStringConvertible) {
        fputs("\(error())\n", stderr)
    }
}
