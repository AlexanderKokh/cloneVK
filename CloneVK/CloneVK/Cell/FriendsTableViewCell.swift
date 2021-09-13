// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var userView: UserView!

    // MARK: - Private Properties

    private lazy var service = VKAPIService()

    // MARK: - Public methods

    func configureCell(user: User, image: UIImage) {
        friendNameLabel.text = "\(user.userName) \(user.userSurname)"
        userView.setupImage(imageName: image)
        backgroundColor = .systemTeal
    }
}
