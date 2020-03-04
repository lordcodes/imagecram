// Copyright (C) 2020 Andrew Lord

public enum ImageCramErrorReason {
    case downloadFailed(error: Error)
    case emptyFilePath
    case emptyFolder
    case missingFile
    case unauthorized
    case unexpectedFile
    case unexpectedFolder
    case uploadFailed(error: Error)

    case other(_ message: String)
}

extension ImageCramErrorReason: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .downloadFailed(error):
            return "Download failed with \(error)"
        case .emptyFilePath:
            return "Empty file path"
        case .emptyFolder:
            return "Empty folder"
        case .missingFile:
            return "Missing file"
        case .unauthorized:
            return "Unauthorized with TinyPNG, please check your API key is set correctly"
        case .unexpectedFile:
            return "Found a file, but expected a folder"
        case .unexpectedFolder:
            return "Found a folder, but expected a file"
        case let .uploadFailed(error):
            return "Upload failed with \(error)"
        case .other(let message):
            return message
        }
    }
}
