// UserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class UserCollectionViewCell: UICollectionViewCell {
    let likeControl = UserImageLikeControl()

    override func awakeFromNib() {
        super.awakeFromNib()

        likeControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(likeControl)

        let likeConstraints = [
            likeControl.leftAnchor.constraint(equalTo: leftAnchor),
            likeControl.rightAnchor.constraint(equalTo: rightAnchor),
            likeControl.topAnchor.constraint(equalTo: topAnchor),
            likeControl.widthAnchor.constraint(equalTo: widthAnchor),
            likeControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ]

        NSLayoutConstraint.activate(likeConstraints)
    }

    func configureCell(userImageName: String) {
        likeControl.setupUserImage(userImageName: userImageName)
    }
}
