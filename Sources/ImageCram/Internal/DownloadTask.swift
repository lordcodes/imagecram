// Copyright (C) 2020 Andrew Lord

import Files
import Foundation

struct DownloadTask {
    let apiKey: String
    private let dispatchGroup = DispatchGroup()

    func download(_ url: URL, to file: File) -> Result<Void, ImageCramError> {
        dispatchGroup.enter()

        var result: Result<Void, ImageCramError>?

        dispatchGroup.wait()

        return result ?? Result.failure(ImageCramError(file, reason: .other("Download did not complete")))
    }
}
