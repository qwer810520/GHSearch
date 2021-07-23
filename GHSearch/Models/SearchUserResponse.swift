//
//  SearchUserResponse.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

struct SearchUserResponse: ResponseFormatter {

  let nextPageParmeter: String
  let lastPageParmeter: String

  private(set) var items: [User]

  init(header: [AnyHashable: Any], data: Data) {
    let linkStr = header["Link"] as? String
    let links = SearchUserResponse.separatedURLParameter(with: linkStr ?? "")
    self.nextPageParmeter = links["rel=\"next\""] ?? ""
    self.lastPageParmeter = links["rel=\"last\""] ?? ""
    do {
      self.items = try data.mapObject(SearchUserList.self).users
    } catch {
      self.items = []
    }
  }

  static func separatedURLParameter(with valueStr: String) -> [String: String] {
    guard !valueStr.isEmpty else { return [:] }
    var result: [String: String] = [:]
    let links = valueStr.components(separatedBy: ", ")
    links.forEach {
      let components = $0.components(separatedBy: "; ")
      let url = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
      let parameter = url.fetchURLParameter()
      result[components[1]] = parameter
    }
    return result
  }
}
