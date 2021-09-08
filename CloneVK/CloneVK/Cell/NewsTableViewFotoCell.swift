// NewsTableViewFotoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewFotoCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var mainNewsImageView: UIImageView!

    // MARK: - Private Properties

    private let service = VKAPIService()

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        mainNewsImageView.contentMode = .scaleAspectFit
        mainNewsImageView.clipsToBounds = true
    }

    // MARK: - Public methods

    func configureCell(news: News) {
        mainNewsImageView.image = service.getFoto(image: news.photo)
    }
}
