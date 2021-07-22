//
//  UIImageView+Ex.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit
import Nuke

extension UIImageView {
  func loadingImage(with url: String) {
    guard let url = URL(string: url) else { return }
    Nuke.loadImage(with: url, into: self)
  }
}
