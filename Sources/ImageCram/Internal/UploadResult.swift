// Copyright (C) 2020 Andrew Lord

import Foundation

struct UploadResult: Decodable {
    let output: Output

    struct Output: Decodable {
        let url: URL
    }
}
