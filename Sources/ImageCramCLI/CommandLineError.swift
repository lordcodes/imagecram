// Copyright (C) 2020 Andrew Lord

import Foundation

enum CommandLineError: Error {
    case apiKeyFileInvalid
    case apiKeyFileMissing
    case apiKeyFilePathEmpty
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
        case .apiKeyFileMissing:
            return "API key file is missing, please try re-running, then updating ImageCram and then reporting the issue on GitHub if it persists."
        case .apiKeyFilePathEmpty:
            return "API key file is missing, please try re-running, then updating ImageCram and then reporting the issue on GitHub if it persists."
        }
    }
}
