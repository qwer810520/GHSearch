//
//  ParentCollectionViewFlowLayout.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

class ParentCollectionViewFlowLayout: UICollectionViewFlowLayout {

  var minimumLine: CGFloat
  var minimumInteritem: CGFloat
  var customItemSize: CGSize
  var customSectionInset: UIEdgeInsets
  var customScrollDirection: UICollectionView.ScrollDirection
  var customHeaderSize: CGSize

  // MARK: - Initialization

  init(withMinimumLineSpacing minimumLineSpacing: CGFloat = 0, minimumInteritemSpacing: CGFloat = 0, itemSize: CGSize = .zero, sectionInset: UIEdgeInsets = .zero, scrollDirection: UICollectionView.ScrollDirection = .vertical, customHeaderSize: CGSize = .zero) {
    self.minimumLine = minimumLineSpacing
    self.minimumInteritem = minimumInteritemSpacing
    self.customItemSize = itemSize
    self.customSectionInset = sectionInset
    self.customScrollDirection = scrollDirection
    self.customHeaderSize = customHeaderSize
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepare() {
    super.prepare()
    minimumLineSpacing = minimumLine
    minimumInteritemSpacing = minimumInteritem

    if customItemSize != .zero {
      itemSize = customItemSize
    }

    if customSectionInset != .zero {
      sectionInset = customSectionInset
    }

    if customHeaderSize != .zero {
      headerReferenceSize = customHeaderSize
    }

    scrollDirection = customScrollDirection
  }
}
