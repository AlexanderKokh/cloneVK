// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var users: [User] = []
    private let reuseIdentifier = "FriendsTableViewCell"
    private var currentUserImage = String()
    private let segueFriendidentifier = "showFriend"
    private var sections: [Character: [User]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addDataToUser()
        addSections()
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
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

        guard let userImageName = sections[sectionTitles[indexPath.section]]?[indexPath.row].userImageName
        else { fatalError() }
        performSegue(withIdentifier: segueFriendidentifier, sender: userImageName)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueFriendidentifier,
              let destination = segue.destination as? FriendsCollectionViewController else { return }
        if let userImage = sender as? String {
            destination.userImage = userImage
        }
    }

    // MARK: - Private methods

    private func addDataToUser() {
        users = [
            User(userName: "Матвей", userImageName: "Матвей"),
            User(userName: "Nikolay", userImageName: "Nikolay"),
            User(userName: "Семён", userImageName: "Семён"),
            User(userName: "Maksim", userImageName: "Maksim"),
            User(userName: "Евгений З.", userImageName: "Евгений З."),
            User(userName: "Полина", userImageName: "Полина"),
            User(userName: "Евгений", userImageName: "Евгений"),
            User(userName: "Vlad", userImageName: "Vlad"),
            User(userName: "Мажит", userImageName: "Мажит"),
            User(userName: "Boris", userImageName: "Boris"),
            User(userName: "Weys", userImageName: "Weys"),
            User(userName: "Эдуард", userImageName: "Эдуард"),
            User(userName: "Tim", userImageName: "Tim"),
            User(userName: "Ардак", userImageName: "Ардак"),
            User(userName: "Юрий", userImageName: "Юрий"),
            User(userName: "Артем", userImageName: "Артем"),
            User(userName: "Евгений", userImageName: "ЕвгенийСова"),
            User(userName: "Dmi3", userImageName: "Dmi3"),
            User(userName: "Max", userImageName: "Max"),
            User(userName: "Тигран", userImageName: "Тигран"),
            User(userName: "Sergey", userImageName: "Sergey"),
            User(userName: "Эдвард", userImageName: "Эдвард"),
            User(userName: "Full Master", userImageName: ""),
            User(userName: "VERA ZAITSEVA", userImageName: "Vera"),
            User(userName: "Valeriy", userImageName: "Валерий"),
            User(userName: "Valeriy", userImageName: "Valeriy"),
        ]
    }

    private func addSections() {
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
