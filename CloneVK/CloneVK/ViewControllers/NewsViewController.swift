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
    private var dateTextCache: [IndexPath: String] = [:]
    private lazy var photoService = PhotoService(container: tableView)
    private lazy var newsAPI = NewsAPIService()
    private var nextFrom = ""

    private var isloading = true

    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        setupPullToRefresh()
    }

    private func setupPullToRefresh() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .systemGray
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "loading...")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    func getCellDateText(forIndexPath indexPath: IndexPath, andTimestamp timestamp: Double) -> String {
        if let stringDate = dateTextCache[indexPath] {
            return stringDate
        } else {
            let date = Date(timeIntervalSince1970: timestamp)
            let stringDate = dateFormatter.string(from: date)
            dateTextCache[indexPath] = stringDate
            return stringDate
        }
    }

    @objc private func refresh() {
        let mostFreshdate = ((news.first?.date) ?? Date().timeIntervalSince1970) + 1

        newsAPI.getNews(startTime: mostFreshdate) { [weak self] news, nextFrom in
            guard let self = self else { return }
            self.tableView.refreshControl?.endRefreshing()
            self.news = news + self.news
            self.tableView.reloadData()
            self.nextFrom = nextFrom
            self.isloading = false
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxRow = indexPaths.map(\.section).max(),
              maxRow > news.count - 3,
              isloading == false else { return }
        isloading = true

        newsAPI.getNews(startFrom: nextFrom) { [weak self] news, nextFrom in
            guard let self = self else { return }
            let oldNewsCount = self.news.count
            let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + news.count)
            self.news.append(contentsOf: news)
            self.tableView.insertSections(indexSet, with: .automatic)
            self.isloading = false
            self.nextFrom = nextFrom
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if news.isEmpty {
            tableView.showEmptyMessage("No news loaded. \nPull screen to load data.")
        } else {
            tableView.hideEmptyMessage()
        }
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = types[indexPath.row]
        let date = getCellDateText(forIndexPath: indexPath, andTimestamp: news[indexPath.section].date)
        switch type {
        case .avatar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: avatarcellIdentifier) as? NewsTableViewCell
            else { fatalError() }
            let image = photoService.photo(atIndexPath: indexPath, byUrl: news[indexPath.section].sourceImageName)
            if image != nil {
                cell.configureCell(news: news[indexPath.section], image: image ?? UIImage(), date: date)
            }
            return cell
        case .foto:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: fotoCelldentifier) as? NewsTableViewFotoCell
            else { fatalError() }
            if !news[indexPath.section].photo.isEmpty {
                let image = photoService.photo(atIndexPath: indexPath, byUrl: news[indexPath.section].photo)
                cell.configureCell(image: image ?? UIImage())
            }
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
