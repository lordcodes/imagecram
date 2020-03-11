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
        let outputUrl = URL(fileURLWithPath: outputPath)
        if outputUrl.pathExtension.isEmpty {
            try FileManager.default.createDirectory(at: outputUrl, withIntermediateDirectories: true, attributes: [:])
            return outputUrl.appendingPathComponent(inputFile.name)
        }
        return outputUrl
    }
}
