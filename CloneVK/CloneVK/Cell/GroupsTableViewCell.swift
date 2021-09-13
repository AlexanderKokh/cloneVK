// GroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class GroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public methods

    func configureCell(group: Group, image: UIImage) {
        groupNameLabel.text = group.groupName
        groupImageView.image = image
    }
}
