// NewsTableViewLikesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewLikesCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var newslikeLabel: UILabel!
    @IBOutlet private var newsRepostLabel: UILabel!
    @IBOutlet private var newsViewsLabel: UILabel!
    @IBOutlet private var newsCommentLabel: UILabel!

    // MARK: - Public methods

    func configureCell(news: News) {
        newslikeLabel.text = news.likes
        newsRepostLabel.text = news.repost
        newsViewsLabel.text = news.views
        newsCommentLabel.text = news.comments
    }
}
