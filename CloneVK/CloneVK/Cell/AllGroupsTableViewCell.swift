// AllGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AllGroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupImageView: UIImageView!

    // MARK: - Private Properties

    private lazy var service = VKAPIService()

    // MARK: - Public methods

    func configureCell(group: Group) {
        groupNameLabel.text = group.groupName
        groupImageView.image = service.getFoto(image: group.groupImageName)
    }
}
