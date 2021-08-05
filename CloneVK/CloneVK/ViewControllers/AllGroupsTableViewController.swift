// AllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Public Properties

    var closure: ((_ groupName: String, _ groupImageName: String) -> ())?

    // MARK: - Private Properties

    private var groups: [Group] = []
    private let reuseIdentifier = "AllGroupsTableViewCell"

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addDataToGroups()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AllGroupsTableViewCell
        else { fatalError() }
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertCompleation(title: "Вступить в группу", message: nil) { [weak self] in
            guard let self = self else { return }
            let groupName = self.groups[indexPath.row].groupName
            let groupImageName = self.groups[indexPath.row].groupImageName
            self.closure?(groupName, groupImageName ?? "")
        }
    }

    // MARK: - Private methods

    private func addDataToGroups() {
        groups = [
            Group(groupName: "Swift", groupImageName: "Swift"),
            Group(groupName: "Cars", groupImageName: "Car"),
            Group(groupName: "Best films", groupImageName: "Best"),
            Group(groupName: "Hack with swift", groupImageName: "Hack with swift"),
            Group(groupName: "IOS developers", groupImageName: "IOS developers"),
            Group(groupName: "IOS magic", groupImageName: "IOS magic"),
            Group(groupName: "Senior for 40 days", groupImageName: "Swift for 40 days")
        ]
    }
}
