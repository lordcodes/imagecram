// Copyright (C) 2021 Andrew Lord

import Foundation

enum StandardInput {
    /// Check if the standard input buffer has received any data.
    /// Useful to prevent blocking the process if when no data is available.
    ///
    /// - Returns: True if there is data waiting to be read.
    static func hasDataAvailable() -> Bool {
        guard let inputStream = InputStream(fileAtPath: "/dev/stdin") else {
            return false
        }
        inputStream.open()
        defer { inputStream.close() }
        return inputStream.hasBytesAvailable
    }

    /// Read full standard input text line by line.
    /// Will block process when used interactively or until data is fully read.
    ///
    /// - Returns: Array of strings with full contents of stdin.
    static func readLines() -> [String] {
        AnyIterator { Swift.readLine() }.compactMap { $0 }
    }
}
