//
//  SearchUserResultView.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

protocol SearchUserResultViewDelegate: class {
  func searchUsers(with keyword: String)
  func prefetchNextPage()
  func dismissKeyboard()
}

class SearchUserResultView: UIView {

  private lazy var inputKeywordView: InputSearchKeyWordView = {
    return InputSearchKeyWordView(delegate: self)
  }()

  private lazy var flowLayout: ParentCollectionViewFlowLayout = {
    return ParentCollectionViewFlowLayout()
  }()

  private lazy var searchResultView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.register(with: [UserResultCell.self])
    view.dataSource = self
    view.delegate = self
    return view
  }()

  private var userList: [User] = []
  weak var delegate: SearchUserResultViewDelegate?

  // MARK: - Initialization

  init(delegate: SearchUserResultViewDelegate? = nil) {
    self.delegate = delegate
    super.init(frame: .zero)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }

  func setupUI(with users: [User]) {
    userList = users
    searchResultView.reloadData()
  }

  func updateCellLayout() {
    searchResultView.collectionViewLayout.invalidateLayout()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubviews([searchResultView, inputKeywordView])
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

  // MARK: - UICollectionViewDelegate

extension SearchUserResultView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: UIScreen.main.bounds.width, height: 70)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.dismissKeyboard()
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let usersCount = userList.count
    DispatchQueue.global().async { [weak self] in
      guard indexPath.item > usersCount - 2 else { return }
      self?.delegate?.prefetchNextPage()
    }
  }
}

  // MARK: - UICollectionViewDataSource

extension SearchUserResultView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userList.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(with: UserResultCell.self, for: indexPath)
    cell.user = userList[indexPath.item]
    return cell
  }
}

  // MARK: - InputSearchKeyWordDelegate

extension SearchUserResultView: InputSearchKeyWordDelegate {
  func searchButtonDidPressed(with Keyword: String) {
    delegate?.searchUsers(with: Keyword)
  }
}
