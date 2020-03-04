// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

struct FileMover {
    let printer: CommandLinePrinter
    let outputPath: String?

    func move(inputPath: String, from localUrl: URL) throws {
        let finalUrl = try outputUrl(for: inputPath)
        do {
            _ = try FileManager.default.replaceItemAt(finalUrl, withItemAt: localUrl)
        } catch {
            throw CommandLineError.failedToMoveFile(from: localUrl.absoluteString, to: finalUrl.absoluteString)
        }
    }

    private func outputUrl(for inputPath: String) throws -> URL {
        guard let inputFile = try? File(path: inputPath) else {
            throw CommandLineError.invalidInputFile(path: inputPath)
        }
        guard let outputPath = outputPath else {
            return inputFile.url
        }
        guard let outputFolder = try? Folder(path: outputPath) else {
            return URL(fileURLWithPath: outputPath)
        }
        return URL(fileURLWithPath: outputFolder.path + "/" + inputFile.name)
    }
}
