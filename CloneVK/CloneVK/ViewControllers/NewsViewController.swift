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
        tableView.delegate = self
        addNews()
    }

    private func addNews() {
        news = [
            News(
                sourceNews: "Футбол | News 24",
                sourceImageName: "IOS developers",
                sourceText: textMessi,
                sourceMainImagename: "messi"
            ),
            News(sourceNews: "IT юмор", sourceImageName: "Swift", sourceText: textITOne, sourceMainImagename: "IT"),
            News(sourceNews: "IT юмор", sourceImageName: "Swift", sourceText: textITOne, sourceMainImagename: "IT2")
        ]
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = types[indexPath.row]
        switch type {
        case .avatar:
            return 80
        case .foto:
            return 400
        case .post:
            return 300
        case .like:
            return 40
        }
    }
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
            return cell
        }
    }
}

private let textMessi1 = """
    Месси на прощальной пресс- конференции

💬«Я был в ступоре и нахожусь в нем до сих пор. Это очень сложно после всего этого долгого пути. Я не был готов.
"""
private let textMessi2 = """
    Год, когда случилась вся эта история с бюрофаксом, остался в прошлом. Но я не хотел уходить в этом году»
"""

private let textMessi3 = """
«Мы были убеждены, что хотим остаться здесь. Это мой дом. Я хотел этого больше всего.
"""

private let textMessi4 = """
Мы всегда подчеркивали наше благополучие, я чувствовал, что здесь мой дом.
    Год, когда случилась вся эта история с бюрофаксом, остался в прошлом.
"""

private let textMessi5 = """
Но я не хотел уходить в этом году»
Я наслаждался жизнью в Барселоне. Это было чудесно»
"""

private let textMessi = textMessi1 + textMessi2 + textMessi3 + textMessi4 + textMessi5

private let textITOne1 = """
Смеёшься с джуном над старым забагованным кодом.
"""

private let textITOne2 = """
C большим количеством уровней вложенности и сомнительными логическими решениями.
"""

private let textITOne3 = """
  По стилистике комментариев понимаешь, что этот код твой.
"""

private let textITOne4 = """
 В панике, пытаясь оправдаться - ищешь хорошие ходы. Говоришь, что это было написано в спешке за пару дней до дедлайна.
"""

private let textITOne5 = """
 Джун в восторге. Ты в депрессии, т.к. писал это говно целый год...
"""

private let textITOne = textITOne1 + textITOne2 + textITOne3 + textITOne4 + textITOne5
