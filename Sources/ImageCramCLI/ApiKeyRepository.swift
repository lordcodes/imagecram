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
            return try findApiKeyFile().readAsString()
        } catch {
            printer.output(message: "Couldn't find a stored API key")
            return nil
        }
    }

    private func findApiKeyFile() throws -> File {
        let preferences = try Folder.home.subfolder(at: preferencesPath)
        return try preferences.file(named: preferencesFile)
    }

    private func readNewKey() throws -> String {
        let instructions = """
        Please enter your TinyPNG API key.
        If you already have a TinyPNG account, you can get the API key from: https://tinypng.com/dashboard/api.
        Otherwise, you can find more details at https://tinypng.com/developers.
        """
        printer.forcedOutput(message: instructions)

        let newKey = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !newKey.isEmpty {
            try write(apiKey: newKey)
        }
        return newKey
    }

    private func write(apiKey: String) throws {
        ensurePreferencesExists()

        do {
            try findApiKeyFile().write(apiKey)
        } catch {
            throw CommandLineError.apiKeyFileInvalid
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
}
