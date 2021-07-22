//
//  InputSearchKeyWordView.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

protocol InputSearchKeyWordDelegate: class {
  func searchButtonDidPressed(with Keyword: String)
}

class InputSearchKeyWordView: UIView {

  private lazy var inputTextField: UITextField = {
    let view = UITextField()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    view.borderStyle = .roundedRect
    view.returnKeyType = .search
    view.placeholder = "Search Keyword..."
    return view
  }()

  weak var delegate: InputSearchKeyWordDelegate?

  // MARK: - Initialization

  init(delegate: InputSearchKeyWordDelegate? = nil) {
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

  // MARK: - Private Methods

  private func setupUserInterface() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(inputTextField)
  }

  private func setupLayout() {
    let views: [String: Any] = ["inputTextField": inputTextField]

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|-space-[inputTextField]-space-|",
                    options: [],
                    metrics: ["space": 15],
                    views: views))

    addConstraints(NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|-space-[inputTextField]-space-|",
                    options: [],
                    metrics: ["space": 10],
                    views: views))
  }
}

  // MARK: - UITextFieldDelegate

extension InputSearchKeyWordView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    delegate?.searchButtonDidPressed(with: textField.text ?? "")
    return true
  }
}
