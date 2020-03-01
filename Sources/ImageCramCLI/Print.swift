// Copyright (C) 2020 Andrew Lord

import Foundation

internal func printError(_ error: CustomStringConvertible) {
    fputs("\(error)\n", stderr)
}
