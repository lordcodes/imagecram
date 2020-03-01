// Copyright (C) 2020 Andrew Lord

import Foundation

public struct ImageCramError: Error {
    let path: String
    let reason: ImageCramErrorReason
}

extension ImageCramError: CustomStringConvertible {
    public var description: String {
        """
        ImageCram encounted an error at '\(path)'.
        Reason: \(reason)
        """
    }
}
