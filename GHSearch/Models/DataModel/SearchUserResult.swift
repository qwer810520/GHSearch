//
//  SearchUserResult.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

struct SearchUserResult: Codable {
  let totalCount: Int
  let items: [User]

  enum Keys: String, CodingKey {
    case totalCount = "total_count"
    case items
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: Keys.self)
    totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount) ?? 0
    items = try values.decodeIfPresent([User].self, forKey: .items) ?? []
  }
}
