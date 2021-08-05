// AllGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AllGroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupImageView: UIImageView!

    // MARK: - Public methods

    func configureCell(group: Group) {
        groupNameLabel.text = group.groupName
        guard let groupAvatar = group.groupImageName else { return }
        groupImageView.image = UIImage(named: groupAvatar)
    }
}
