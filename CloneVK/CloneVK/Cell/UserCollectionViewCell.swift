// UserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class UserCollectionViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let likeControl = UserImageLikeControl()

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    // MARK: - Public methods

    func configureCell(userImageName: String) {
        likeControl.setupUserImage(userImageName: userImageName)
    }

    // MARK: - Private methods

    private func setupCell() {
        likeControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(likeControl)

        let likeConstraints = [
            likeControl.leftAnchor.constraint(equalTo: leftAnchor),
            likeControl.rightAnchor.constraint(equalTo: rightAnchor),
            likeControl.topAnchor.constraint(equalTo: topAnchor),
            likeControl.widthAnchor.constraint(equalTo: widthAnchor),
            likeControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(likeConstraints)
    }
}
