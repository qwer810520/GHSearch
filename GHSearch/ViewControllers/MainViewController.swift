//
//  MainViewController.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

class MainViewController: UIViewController {

  private lazy var baseView: SearchUserResultView = {
    let view = SearchUserResultView()
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUserInterface()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    view.addSubview(baseView)
    title = "Search"
    setupLayout()
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      baseView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
      baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      baseView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0)
    ])
  }
}
