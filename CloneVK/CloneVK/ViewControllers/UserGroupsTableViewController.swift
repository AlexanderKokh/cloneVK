// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class GroupsTableViewController: UITableViewController {
    // MARK: - Private Properties

    // private var groups: [Group] = []
    private let reuseIdentifier = "GroupsTableViewCell"

    var testgroups: [TestGroup] = []

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        let service = VKAPIService()

        service.getGroups2 { [weak self] groups in
            self?.testgroups = groups
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testgroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as? GroupsTableViewCell else { fatalError() }
        cell.configureCell(group: testgroups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            testgroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AllGroupsTableViewController else { return }
        destination.closure = { [weak self] groupName, groupImageName in
            guard let self = self else { return }
            self.testgroups.append(TestGroup(groupName: groupName, groupImageName: groupImageName))
            self.tableView.reloadData()
        }
    }
}
