// Copyright (C) 2020 Andrew Lord

import Foundation

struct ApiError: Decodable, Error {
    let error: String
    let message: String
}

extension ApiError: CustomStringConvertible {
    public var description: String {
        "\(error) - \(message)"
    }
}
