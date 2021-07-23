//
//  User.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

struct User: Codable {
  let login: String
  let avatarUrl: String

  enum Keys: String, CodingKey {
    case login
    case avatarUrl = "avatar_url"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: Keys.self)
    login = try values.decodeIfPresent(String.self, forKey: .login) ?? ""
    avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl) ?? ""
  }
}
