//
//  UserResultCell.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import UIKit

class UserResultCell: UICollectionViewCell {

  private lazy var userPhotoImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = 4
    view.clipsToBounds = true
    return view
  }()

  private lazy var userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.numberOfLines = 2
    return label
  }()

  private lazy var bottomSeparateLine: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .lightGray
    return view
  }()

  var user: User? {
    didSet {
      guard let user = user else { return }
      userNameLabel.text = user.login
      userPhotoImageView.loadingImage(with: user.avatarUrl)
    }
  }

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUserInterface()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    userPhotoImageView.image = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }

  // MARK: - Private Methods

  private func setupUserInterface() {
    contentView.addSubviews([userPhotoImageView, bottomSeparateLine, userNameLabel])
  }

  private func setupLayout() {
    let views: [String: Any] = ["bottomSeparateLine": bottomSeparateLine, "userPhotoImageView": userPhotoImageView, "userNameLabel": userNameLabel]

    contentView.addConstraints(NSLayoutConstraint.constraints(
                                withVisualFormat: "H:|-space-[userPhotoImageView(width)]-space-[userNameLabel]-space-|",
                                options: [],
                                metrics: ["space": 10, "width": contentView.frame.height - 10],
                                views: views))

    contentView.addConstraints(NSLayoutConstraint.constraints(
                                withVisualFormat: "V:|-space-[userPhotoImageView]-space-|",
                                options: [],
                                metrics: ["space": 5],
                                views: views))

    contentView.addConstraints(NSLayoutConstraint.constraints(
                                withVisualFormat: "V:|-space-[userNameLabel]-space-|",
                                options: [],
                                metrics: ["space": 5],
                                views: views))

    contentView.addConstraints(NSLayoutConstraint.constraints(
                                withVisualFormat: "H:|-space-[bottomSeparateLine]-space-|",
                                options: [],
                                metrics: ["space": 15],
                                views: views))

    contentView.addConstraints(NSLayoutConstraint.constraints(
                                withVisualFormat: "V:[bottomSeparateLine(height)]|",
                                options: [],
                                metrics: ["height": 1],
                                views: views))
  }
}
