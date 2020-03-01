// Copyright (C) 2020 Andrew Lord

public enum ImageCramErrorReason {
    case emptyFilePath
    case emptyFolder
    case missingFile
    case unexpectedFile
    case unexpectedFolder

    case other(message: String)
}

extension ImageCramErrorReason: CustomStringConvertible {
    public var description: String {
        switch self {
        case .emptyFilePath:
            return "Empty file path"
        case .emptyFolder:
            return "Empty folder"
        case .missingFile:
            return "Missing file"
        case .unexpectedFile:
            return "Found a file, but expected a folder"
        case .unexpectedFolder:
            return "Found a folder, but expected a file"
        case .other(let message):
            return message
        }
    }
}
