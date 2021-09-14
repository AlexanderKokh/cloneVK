// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var avatarNewsImageView: UIImageView!
    @IBOutlet private var avatarNewsLabel: UILabel!

    // MARK: - Private Properties

    private let sevice = VKAPIService()

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarNewsImageView.contentMode = .scaleAspectFill
    }

    // MARK: - Public methods

    func configureCell(news: News, image: UIImage) {
        avatarNewsImageView.image = image
        avatarNewsLabel.text = news.sourceNews
    }
}
