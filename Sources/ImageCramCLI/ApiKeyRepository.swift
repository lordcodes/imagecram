// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

private let preferencesPath = "Library/Preferences/ImageCram"
private let preferencesFile = "apikey.txt"

struct ApiKeyRepository {
    func read() -> String {
        let storedKey = readStoredKey()
        guard let apiKey = storedKey, !apiKey.isEmpty else {
            return readNewKey()
        }
        return apiKey
    }

    func write(apiKey: String) {
        ensurePreferencesExists()

        do {
            let preferences = try Folder.home.subfolder(at: preferencesPath)
            let apiKeyFile = try preferences.file(named: preferencesFile)
            try apiKeyFile.write(apiKey)
        } catch {
            // TODO: Handle different errors to here and log details of why no API key was found
        }
    }
}

private extension ApiKeyRepository {
    func readStoredKey() -> String? {
        do {
            let preferences = try Folder.home.subfolder(at: preferencesPath)
            let apiKeyFile = try preferences.file(named: preferencesFile)
            return try apiKeyFile.readAsString()
        } catch {
            // TODO: Handle different errors to here and log details of why no API key was found
            return nil
        }
    }

    func readNewKey() -> String {
        let newKey = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !newKey.isEmpty {
            write(apiKey: newKey)
        }
        return newKey
    }

    // TODO: Handle errors rather than using try?
    func ensurePreferencesExists() {
        let root = Folder.home
        if !root.containsSubfolder(at: preferencesPath) {
            _ = try? root.createSubfolder(at: preferencesPath)
        }
        let preferences = try? root.subfolder(at: preferencesPath)
        if preferences?.containsFile(named: preferencesFile) == false {
            _ = try? preferences?.createFile(named: preferencesFile)
        }
    }
}
