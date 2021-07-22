//
//  APIManager.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

enum APIManager {
  case searchUser(SearchParametersInfo)
}

  // MARK: - TargetType

extension APIManager: TargetType {
  var baseURL: String {
    return "https://api.github.com/search/users"
  }

  var path: String {
    switch self {
      case let .searchUser(info):
        return "?q=\(info.keywordURLEncoded)&per_page=\(info.perPageCount)&page=\(info.page)"
    }
  }

  var method: HTTPMethod {
    return .GET
  }

  var parameters: JSONDictionary? {
    switch method {
      case .GET: return nil
      default:
        return [:]
    }
  }

  var headers: [String: String]? {
    return ["Accept": "application/vnd.github.v3+json"]
  }
}
