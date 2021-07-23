//
//  SearchParametersInfo.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

struct SearchParametersInfo {
  let firstPageParameter: String
  var nextPageParameter: String
  var lastPageParameter: String

  let perPageCount: Int = 20

  var isLastPage: Bool {
    return lastPageParameter == nextPageParameter
  }

  init(keyword: String) {
    self.firstPageParameter = "q=\(keyword.urlEncoded())&per_page=\(self.perPageCount)&page=\(1)"
    self.nextPageParameter = ""
    self.lastPageParameter = ""
  }

  mutating func updatePageParmeter(with info: SearchUserResponse) {
    self.nextPageParameter = info.nextPageParmeter
    self.lastPageParameter = info.lastPageParmeter
  }
}
