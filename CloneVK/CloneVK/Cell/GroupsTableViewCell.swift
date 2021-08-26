// GroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class GroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Private Properties

    private lazy var service = VKAPIService()

    // MARK: - Public methods

    func configureCell(group: Group) {
        groupNameLabel.text = group.groupName
        groupImageView.image = service.getFoto(image: group.groupImageName)
    }
}
