// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

struct FileParser {
    private let fileManager = FileManager.default

    func parse(filePath: String) throws -> File {
        let exists = fileManager.fileExists(atPath: filePath)
        if !exists {
            throw ImageCramError(filePath, reason: .missingFile)
        }
        do {
            return try File(path: filePath)
        } catch {
            throw parseError(for: filePath, from: error)
        }
    }
}

private extension FileParser {
    func parseError(for path: String, from error: Error) -> ImageCramError {
        if let locationError = error as? LocationError {
            let reason = parseErrorReason(from: locationError)
            return ImageCramError(path, reason: reason)
        }
        return ImageCramError(path, reason: .other(error.localizedDescription))
    }

    func parseErrorReason(from error: LocationError) -> ImageCramErrorReason {
        switch error.reason {
        case .emptyFilePath:
            return .emptyFilePath
        case .missing:
            return .unexpectedFolder
        default:
            return .other(error.localizedDescription)
        }
    }
}
