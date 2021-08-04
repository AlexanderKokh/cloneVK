// UserCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet var userImageView: UIImageView!

    func configureCell(userImageName: String) {
        userImageView.image = UIImage(named: userImageName)
    }
}
