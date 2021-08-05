// UserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class UserCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var userImageView: UIImageView!

    // MARK: - Public methods

    func configureCell(userImageName: String) {
        userImageView.image = UIImage(named: userImageName)
    }
}
