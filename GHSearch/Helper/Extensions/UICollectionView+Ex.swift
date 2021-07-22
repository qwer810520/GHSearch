//
//  UICollectionView+Ex.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

extension UICollectionView {
  func register(with cells: [UICollectionViewCell.Type]) {
    cells.forEach { register($0.self, forCellWithReuseIdentifier: $0.identifier) }
  }

  func registerHeader(with headers: [UICollectionReusableView.Type]) {
    headers.forEach { register($0.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: $0.identifier) }
  }

  func registerFooter(with footers: [UICollectionReusableView.Type]) {
    footers.forEach { register($0.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: $0.identifier) }
  }

  func dequeueReusableCell<T: UICollectionViewCell>(with cell: T.Type, for indexPath: IndexPath) -> T {
    guard let customCell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
      fatalError("\(cell.identifier) Initialization Fail")
    }
    return customCell
  }
}
