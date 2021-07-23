//
//  Data+Ex.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

extension Data {
  func mapObject<T: Decodable>(_ type: T.Type) throws -> T {
    return try JSONDecoder().decode(T.self, from: self)
  }
}
