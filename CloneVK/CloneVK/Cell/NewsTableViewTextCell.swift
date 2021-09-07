// NewsTableViewTextCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewTextCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var textNewsLabel: UILabel!

    // MARK: - Public methods

    func configureCell(news: News) {
        textNewsLabel.text = news.sourceText
    }
}
