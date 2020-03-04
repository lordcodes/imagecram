// Copyright (C) 2020 Andrew Lord

import Foundation

extension Data {
    func decoded<T: Decodable>(as type: T.Type = T.self,
                               using decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
}
