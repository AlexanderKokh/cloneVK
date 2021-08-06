// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet var userView: UserView!

    // MARK: - Public methods

    func configureCell(user: User) {
        friendNameLabel.text = user.userName
        guard let avatarName = user.userImageName else { return }
        userView.setupImage(imageName: avatarName)
    }
}
