// Copyright (C) 2020 Andrew Lord

import Foundation

enum CommandLineError: Error {
    case apiKeyFileInvalid
    case failedToMoveFile(from: String, to: String)
    case invalidInputFile(path: String)
    case invalidOutput(path: String)
}

extension CommandLineError: CustomStringConvertible {
    public var description: String {
        """
        ImageCram encounted an error.
        Reason: \(reason)
        """
    }

    private var reason: String {
        switch self {
        case .apiKeyFileInvalid:
            return "API key file is missing, please try re-running, then updating ImageCram and then reporting the issue on GitHub if it persists."
        case let .failedToMoveFile(from, to):
            return "Failed to move file from \(from) to \(to)"
        case let .invalidInputFile(path):
            return "Cannot read input file at \(path)"
        case let .invalidOutput(path):
            return "Specified output isn't a valid file or folder: \(path)"
        }
    }
}
