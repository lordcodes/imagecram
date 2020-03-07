// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

public struct ImageCramError: Error {
    let path: String
    let reason: ImageCramErrorReason

    init(_ path: String, reason: ImageCramErrorReason) {
        self.path = path
        self.reason = reason
    }

    init(_ file: File, reason: ImageCramErrorReason) {
        self.init(file.path, reason: reason)
    }
}

extension ImageCramError: CustomStringConvertible {
    public var description: String {
        """
        ImageCram encounted an error at '\(path)'.
        Reason: \(reason)
        """
    }
}
