// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var userView: UserView!

    // MARK: - Public methods

    func configureCell(user: TestUser) {
        friendNameLabel.text = user.userName + " " + user.userSurname
        let photoUIImage = getFoto(image: user.userPhoto)
        userView.setupImage(imageName: photoUIImage)
        backgroundColor = .systemTeal
    }

    private func getFoto(image: String) -> UIImage {
        guard let imageURL = URL(string: image),
              let data = try? Data(contentsOf: imageURL),
              let image = UIImage(data: data) else { return UIImage() }
        return image
    }
}
