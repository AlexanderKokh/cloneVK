// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsViewController: UIViewController {
    enum CellTypes {
        case avatar
        case post
        case foto
        case like
    }

    // MARK: - IBOutlet

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private Properties

    private var news: [News] = []
    private let avatarcellIdentifier = "NewsTableViewCell"
    private let fotoCelldentifier = "NewsTableViewFotoCell"
    private let likesCellIdentifier = "NewsTableViewLikesCell"
    private let textCellIdentifier = "NewsTableViewTextCell"
    private let types: [CellTypes] = [.avatar, .post, .foto, .like]

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 1
        tableView.delegate = self

        let newsAPI = NewsAPIService()
        newsAPI.getNews { [weak self] news in
            guard let self = self else { return }
            self.news = news
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let type = types[indexPath.row]
//        switch type {
//        case .avatar:
//            return 80
//        case .foto:
//            return 400
//        case .post:
//            return 300
//        case .like:
//            return 40
//        }
//    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = types[indexPath.row]

        switch type {
        case .avatar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: avatarcellIdentifier) as? NewsTableViewCell
            else { fatalError() }
            cell.configureCell(news: news[indexPath.section])
            return cell
        case .foto:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: fotoCelldentifier) as? NewsTableViewFotoCell
            else { fatalError() }
            cell.configureCell(news: news[indexPath.section])
            return cell
        case .post:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier) as? NewsTableViewTextCell
            else { fatalError() }
            cell.configureCell(news: news[indexPath.section])
            return cell
        case .like:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: likesCellIdentifier)
                as? NewsTableViewLikesCell
            else { fatalError() }
            cell.configureCell(news: news[indexPath.section])
            return cell
        }
    }
}
