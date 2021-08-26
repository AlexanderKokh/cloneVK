// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class GroupsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private let reuseIdentifier = "GroupsTableViewCell"
    private var groups: [Group] = []
    private lazy var service = VKAPIService()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as? GroupsTableViewCell else { fatalError() }
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AllGroupsTableViewController else { return }
        destination.closure = { [weak self] groupName, groupImageName in
            guard let self = self else { return }
            self.groups.append(Group(groupName: groupName, groupImageName: groupImageName))
            self.tableView.reloadData()
        }
    }

    private func setupView() {
        service.getGroups { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }
}
