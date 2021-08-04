// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewController: UITableViewController {
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
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
            User(userName: "Ардак", userImageName: "Ардак")
        ]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "FriendsTableViewCell", for: indexPath) as? FriendsTableViewCell
        else { fatalError() }
        cell.configureCell(user: users[indexPath.row])
        return cell
    }
}
