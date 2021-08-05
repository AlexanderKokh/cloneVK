// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var users: [User] = []
    private let reuseIdentifier = "FriendsTableViewCell"
    private var currentUserImage = ""

    weak var delegate: ShowUserImage?

    // MARK: - UIViewController

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FriendsTableViewCell
        else { fatalError() }
        cell.configureCell(user: users[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView
            .dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) is FriendsTableViewCell
        else { fatalError() }
        if let userImageName = users[indexPath.row].userImageName {
            // delegate?.setUserImage(userImageName: userImageName)
            currentUserImage = userImageName
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFriend" else { return }
        guard let destination = segue.destination as? FriendsCollectionViewController else { return }
        destination.userImage = currentUserImage
    }
}
