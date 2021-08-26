// GroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class GroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public methods

    func configureCell(group: TestGroup) {
        groupNameLabel.text = group.groupName
        groupImageView.image = getFoto(image: group.groupImageName)
    }

    private func getFoto(image: String) -> UIImage {
        guard let imageURL = URL(string: image),
              let data = try? Data(contentsOf: imageURL),
              let image = UIImage(data: data) else { return UIImage() }
        return image
    }
}
