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
}
