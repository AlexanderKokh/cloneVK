// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var textNewsLabel: UILabel!
    @IBOutlet private var avatarNewsImageView: UIImageView!
    @IBOutlet private var avatarNewsLabel: UILabel!
    @IBOutlet private var mainNewsImageView: UIImageView!

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarNewsImageView.contentMode = .scaleAspectFit
        mainNewsImageView.contentMode = .scaleAspectFill
        mainNewsImageView.clipsToBounds = true
    }

    // MARK: - Public methods

    func configureCell(news: News) {
        avatarNewsImageView.image = UIImage(named: news.sourceImageName)
        avatarNewsLabel.text = news.sourceNews
        textNewsLabel.text = news.sourceText
        guard let mainNewsImage = news.sourceMainImagename else { return }
        mainNewsImageView.image = UIImage(named: mainNewsImage)
    }
}
