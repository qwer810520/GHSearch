//
//  SearchUserList.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

struct SearchUserList: Decodable {
  let users: [User]

  enum Keys: String, CodingKey {
    case items
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: Keys.self)
    users = try values.decodeIfPresent([User].self, forKey: .items) ?? []
  }
}
