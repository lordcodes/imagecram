// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

struct FileParser {
    private let fileManager = FileManager.default

    func parse(filePath: String) throws -> File {
        let exists = fileManager.fileExists(atPath: filePath)
        if !exists {
            throw ImageCramError(path: filePath, reason: .missingFile)
        }
        do {
            return try File(path: filePath)
        } catch {
            throw parseError(from: error)
        }
    }
}

private extension FileParser {
    func parseError(from error: Error) -> ImageCramError {
        if let locationError = error as? LocationError {
            let reason = parseErrorReason(from: locationError)
            return ImageCramError(path: locationError.path, reason: reason)
        }
        return ImageCramError(path: "path", reason: .other(message: error.localizedDescription))
    }

    func parseErrorReason(from error: LocationError) -> ImageCramErrorReason {
        switch error.reason {
        case .emptyFilePath:
            return .emptyFilePath
        case .missing:
            return .unexpectedFolder
        default:
            return .other(message: error.localizedDescription)
        }
    }
}
