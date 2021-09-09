// UserGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

final class GroupsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var realm = try? Realm()
    private var notificationToken: NotificationToken?
    private var groups: Results<Group>?
    private let reuseIdentifier = "GroupsTableViewCell"
    private lazy var service = GroupAPIService()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as? GroupsTableViewCell,
            let groups = groups else { fatalError() }
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            guard let groups = groups else { return }
            deleteGroup(groups[indexPath.row])
            reloadTable()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AllGroupsTableViewController else { return }
        destination.closure = { [weak self] groupName, groupImageName in
            guard let self = self else { return }
            self.addGroup(groupName: groupName, groupImageName: groupImageName)
            self.reloadTable()
        }
    }

    // MARK: - Private methods

    private func setupView() {
        bindViewWithRealm()
        service.getGroups()
    }

    private func bindViewWithRealm() {
        guard let userGroups = realm?.objects(Group.self) else { return }

        groups = userGroups

        notificationToken = groups?.observe { change in
            switch change {
            case .initial:
                break
            case .update:
                self.tableView.reloadData()
            case let .error(error):
                print(error)
            }
        }
    }

    private func addGroup(groupName: String, groupImageName: String) {
        let newGroup = Group(groupName: groupName, groupImageName: groupImageName)

        do {
            try realm?.write {
                realm?.add(newGroup)
            }
        } catch {
            print(error)
        }
    }

    private func deleteGroup(_ group: Group) {
        do {
            try realm?.write {
                realm?.delete(group)
            }
        } catch {
            print(error)
        }
    }

    private func reloadTable(_ animated: Bool = true) {
        animated ? tableView.reloadSections(IndexSet(integer: 0), with: .fade) : tableView.reloadData()
    }
}
