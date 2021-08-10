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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public methods

    func configureCell(news: News) {
        avatarNewsImageView.contentMode = .scaleAspectFit
        avatarNewsImageView.image = UIImage(named: news.sourceImageName)
        avatarNewsLabel.text = news.sourceNews
        textNewsLabel.text = news.sourceText
        guard let mainNewsImage = news.sourceMainImagename else { return }
        mainNewsImageView.contentMode = .scaleToFill
        mainNewsImageView.clipsToBounds = true
        mainNewsImageView.image = UIImage(named: mainNewsImage)
    }
}
