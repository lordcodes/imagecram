// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

struct ApiKeyRepository {
    func read() -> String? {
        do {
            let preferences = try Folder.home.subfolder(at: "Library/Preferences/ImageCram")
            let apiKeyFile = try preferences.file(named: "apikey.txt")
            return try apiKeyFile.readAsString()
        } catch {
            // TODO: Handle different errors to here and log details of why no API key was found
            return nil
        }
    }
}
