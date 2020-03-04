// Copyright (C) 2020 Andrew Lord

import Files
import Foundation
import ImageCram

private let preferencesPath = "Library/Preferences/ImageCram"
private let preferencesFile = "apikey.txt"

struct ApiKeyRepository {
    let printer: CommandLinePrinter

    func read() throws -> String {
        let storedKey = try readStoredKey()
        guard let apiKey = storedKey, !apiKey.isEmpty else {
            return try readNewKey()
        }
        return apiKey
    }

    private func readStoredKey() throws -> String? {
        do {
            let preferences = try Folder.home.subfolder(at: preferencesPath)
            let apiKeyFile = try preferences.file(named: preferencesFile)
            return try apiKeyFile.readAsString()
        } catch {
            printer.output(message: "Couldn't find a stored API key")
            return nil
        }
    }

    private func readNewKey() throws -> String {
        printer.forcedOutput(message: "Please enter your TinyPNG API key. More details at https://tinypng.com/developers")
        let newKey = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !newKey.isEmpty {
            try write(apiKey: newKey)
        }
        return newKey
    }

    private func write(apiKey: String) throws {
        ensurePreferencesExists()

        do {
            let preferences = try Folder.home.subfolder(at: preferencesPath)
            let apiKeyFile = try preferences.file(named: preferencesFile)
            try apiKeyFile.write(apiKey)
        } catch {
            throw parseError(from: error)
        }
    }

    private func ensurePreferencesExists() {
        let root = Folder.home
        if !root.containsSubfolder(at: preferencesPath) {
            _ = try? root.createSubfolder(at: preferencesPath)
        }
        let preferences = try? root.subfolder(at: preferencesPath)
        if preferences?.containsFile(named: preferencesFile) == false {
            _ = try? preferences?.createFile(named: preferencesFile)
        }
    }

    private func parseError(from error: Error) -> CommandLineError {
        if let locationError = error as? LocationError {
            return locationError.forCommandLine()
        }
        return .apiKeyFileInvalid
    }
}

private extension LocationError {
    func forCommandLine() -> CommandLineError {
        switch reason {
        case .emptyFilePath:
            return .apiKeyFilePathEmpty
        case .missing:
            return .apiKeyFileMissing
        default:
            return .apiKeyFileInvalid
        }
    }
}
