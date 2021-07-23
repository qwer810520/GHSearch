//
//  MainViewController.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

class MainViewController: UIViewController {

  private lazy var resultView: SearchUserResultView = {
    return SearchUserResultView(delegate: self)
  }()

  private var viewModel: SearchUserViewModel?

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = SearchUserViewModel()
    setupUserInterface()
    binded()
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    resultView.updateCellLayout()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    view.addSubview(resultView)
    view.backgroundColor = .white
    title = "Search"
    setupLayout()
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      resultView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
      resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      resultView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0)
    ])
  }

  private func binded() {
    viewModel?.userList = { [weak self] users in
      self?.resultView.setupUI(with: users)
      self?.title = "Search"
    }

    viewModel?.requestError = { [weak self] errorMessage in
      print(errorMessage)
      self?.title = errorMessage
    }
  }
}

  // MARK: - SearchUserResultViewDelegate

extension MainViewController: SearchUserResultViewDelegate {
  func dismissKeyboard() {
    view.endEditing(true)
  }

  func searchUsers(with keyword: String) {
    viewModel?.searchUser(with: keyword)
  }

  func prefetchNextPage() {
    viewModel?.fetchNextPage()
  }
}
