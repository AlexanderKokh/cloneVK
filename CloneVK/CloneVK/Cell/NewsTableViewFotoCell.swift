// NewsTableViewFotoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewFotoCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var mainNewsImageView: UIImageView!

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        mainNewsImageView.contentMode = .scaleAspectFit
        mainNewsImageView.clipsToBounds = true
    }

    // MARK: - Public methods

    func configureCell(news: News) {
        guard let mainNewsImage = news.sourceMainImagename else { return }
        mainNewsImageView.image = UIImage(named: mainNewsImage)
    }
}
