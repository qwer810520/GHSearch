//
//  String+Ex.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

extension String {
  func urlEncoded() -> String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }

  func fetchURLParameter() -> String? {
    guard let separateSymbolIndex = self.firstIndex(of: "?") else { return nil }
    let startIndex = self.index(after: separateSymbolIndex)
    return String(self[startIndex...])
  }
}
