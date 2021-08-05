// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var friendNameLabel: UILabel!

    // MARK: - Public methods

    func configureCell(user: User) {
        friendNameLabel.text = user.userName
        guard let avatarName = user.userImageName else { return }
        friendImageView.image = UIImage(named: avatarName)
    }
}