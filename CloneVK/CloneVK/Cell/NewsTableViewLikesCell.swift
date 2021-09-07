// NewsTableViewLikesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewLikesCell: UITableViewCell {
    @IBOutlet var newslikeLabel: UILabel!
    @IBOutlet var newsRepostLabel: UILabel!
    @IBOutlet var newsViewsLabel: UILabel!
    @IBOutlet var newsCommentLabel: UILabel!

    func configureCell(news: News) {
        newslikeLabel.text = news.likes
        newsRepostLabel.text = news.repost
        newsViewsLabel.text = news.views
        newsCommentLabel.text = news.comments
    }
}
