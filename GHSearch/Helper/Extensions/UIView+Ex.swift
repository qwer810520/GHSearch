//
//  UIView+Ex.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach { addSubview($0) }
  }
}
