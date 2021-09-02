// AllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import FirebaseDatabase
import UIKit

final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Public Properties

    var closure: ((_ groupName: String, _ groupImageName: String) -> ())?

    // MARK: - IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private Properties

    private var groups: [Group] = []
    private var currentGroupName = String()
    private var fireBaseUserGroups: [String] = []
    private let reuseIdentifier = "AllGroupsTableViewCell"
    private let databaseRef = Database.database().reference().child("UserGroup").child(Session.shared.applicationUserID)
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
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AllGroupsTableViewCell
        else { fatalError() }
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertCompleation(title: "Вступить в группу", message: nil) { [weak self] in
            guard let self = self else { return }
            self.currentGroupName = self.groups[indexPath.row].groupName
            self.addUserGroupsFirebase {
                let groupName = self.groups[indexPath.row].groupName
                let groupImageName = self.groups[indexPath.row].groupImageName
                self.closure?(groupName, groupImageName)
            }
        }
    }

    // MARK: - Private methods

    private func setupView() {
        searchBar.delegate = self
    }

    private func addUserGroupsFirebase(compleation: @escaping () -> ()) {
        databaseRef.getData { _, snapshot in
            if let users = snapshot.value as? [String] {
                self.fireBaseUserGroups = users
            }

            guard !self.fireBaseUserGroups.contains(self.currentGroupName) else { return }
            self.fireBaseUserGroups.append(self.currentGroupName)
            self.databaseRef.setValue(self.fireBaseUserGroups)

            compleation()
        }
    }
}

// MARK: - UISearchBarDelegate

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        service.groupsSearch(search: searchText) { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }
}
