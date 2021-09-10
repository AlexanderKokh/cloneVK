// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var realm = try? Realm()
    private var users: Results<User>?
    private var notificationToken: NotificationToken?
    private let reuseIdentifier = "FriendsTableViewCell"
    private let segueFriendidentifier = "showFriend"
    private var sections: [Character: [User]] = [:]
    private var sectionTitles: [Character] = []
    private lazy var service = UserAPIService()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        getFriends()
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))

        headerView.backgroundColor = .systemTeal
        headerView.alpha = 0.5

        let headerlabel = UILabel()
        headerlabel.frame = CGRect(x: 0, y: -20, width: headerView.frame.width - 40, height: headerView.frame.height)
        headerlabel.text = String(sectionTitles[section])
        headerlabel.font = .systemFont(ofSize: 20, weight: .heavy)
        headerlabel.textColor = .black

        headerView.addSubview(headerlabel)

        return headerView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[sectionTitles[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FriendsTableViewCell
        else { fatalError() }

        guard let user = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
        cell.configureCell(user: user)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView
            .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) is FriendsTableViewCell
        else { fatalError() }

        guard let userImageName = sections[sectionTitles[indexPath.section]]?[indexPath.row].userID
        else { fatalError() }
        performSegue(withIdentifier: segueFriendidentifier, sender: userImageName)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueFriendidentifier,
              let destination = segue.destination as? AllFriendFotoViewController else { return }
        if let userImage = sender as? Int {
            destination.userID = String(userImage)
        }
    }

    // MARK: - Private methods

    private func getFriends() {
        bindViewWithRealm()
        service.getFriends()
    }

    private func bindViewWithRealm() {
        guard let friends = realm?.objects(User.self) else { return }

        users = friends

        notificationToken = users?.observe { change in
            switch change {
            case .initial:
                self.addSections()
                self.tableView.reloadData()
            case .update:
                self.sectionTitles = []
                self.sections = [:]
                self.addSections()
                self.tableView.reloadData()
            case let .error(error):
                print(error)
            }
        }
    }

    private func addSections() {
        guard let users = users else { return }
        for user in users {
            guard let firstLetter = user.userName.first else { return }
            if sections[firstLetter] != nil {
                sections[firstLetter]?.append(user)
            } else {
                sections[firstLetter] = [user]
            }
        }
        sectionTitles = Array(sections.keys)
        sectionTitles.sort()
    }
}
