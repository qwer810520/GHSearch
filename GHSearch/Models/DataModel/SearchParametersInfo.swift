//
//  SearchParametersInfo.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

struct SearchParametersInfo {
  let keyword: String
  let perPageCount: Int
  var page: Int

  var keywordURLEncoded: String {
    return keyword.urlEncoded()
  }

  init(keyword: String) {
    self.keyword = keyword
    self.perPageCount = 1
    self.page = 1
  }
}
