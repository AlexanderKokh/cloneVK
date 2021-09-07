// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var avatarNewsImageView: UIImageView!
    @IBOutlet private var avatarNewsLabel: UILabel!

    // MARK: - Initializers

    let sevice = VKAPIService()

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarNewsImageView.contentMode = .scaleAspectFit
    }

    // MARK: - Public methods

    func configureCell(news: News) {
        avatarNewsImageView.image = sevice.getFoto(image: news.sourceImageName)
        avatarNewsLabel.text = news.sourceNews
    }
}
