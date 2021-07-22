//
//  SearchUserResultView.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

class SearchUserResultView: UIView {

  private lazy var inputKeywordView: InputSearchKeyWordView = {
    return InputSearchKeyWordView(delegate: self)
  }()

  private lazy var flowLayout: ParentCollectionViewFlowLayout = {
    let layout = ParentCollectionViewFlowLayout(itemSize: .init(width: UIScreen.main.bounds.width, height: 70))
    return layout
  }()

  private lazy var searchResultView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.register(with: [UserResultCell.self])
    view.dataSource = self
    return view
  }()

  // MARK: - Initialization

  init() {
    super.init(frame: .zero)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews([searchResultView, inputKeywordView])
    setupLayout()
  }

  private func setupLayout() {
    let views: [String: Any] = ["collectionView": searchResultView, "inputKeywordView": inputKeywordView]

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[inputKeywordView]|",
                    options: [],
                    metrics: nil,
                    views: views))

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[collectionView]|",
                    options: [],
                    metrics: nil,
                    views: views))

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[inputKeywordView(inputViewHeight)][collectionView]|",
                    options: [],
                    metrics: ["inputViewHeight": 60],
                    views: views))
  }
}

  // MARK: - UICollectionViewDataSource

extension SearchUserResultView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(with: UserResultCell.self, for: indexPath)
    return cell
  }
}

  // MARK: - InputSearchKeyWordDelegate

extension SearchUserResultView: InputSearchKeyWordDelegate {
  func searchButtonDidPressed(with Keyword: String) {
    print("search keyword: \(Keyword)")
  }
}
