// AllGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AllGroupsTableViewController: UITableViewController {
    // MARK: - Public Properties

    var closure: ((_ groupName: String, _ groupImageName: String) -> ())?

    // MARK: - IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private Properties

    private var groups: [Group] = []
    private var searchGroups: [Group] = []
    private var searching = false
    private let reuseIdentifier = "AllGroupsTableViewCell"

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchGroups.count
        } else {
            return groups.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AllGroupsTableViewCell
        else { fatalError() }
        if searching {
            cell.configureCell(group: searchGroups[indexPath.row])
        } else {
            cell.configureCell(group: groups[indexPath.row])
        }
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

    private func setupView() {
        searchBar.delegate = self
        addDataToGroups()
    }

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

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroups = groups.filter { $0.groupName.prefix(searchText.count).lowercased() == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
}
