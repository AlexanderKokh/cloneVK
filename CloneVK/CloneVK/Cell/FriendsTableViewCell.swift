// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet var friendImageView: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(user: User) {
        friendNameLabel.text = user.userName
        if let avatarName = user.userImageName {
            friendImageView.image = UIImage(named: avatarName)
        }
    }
}
