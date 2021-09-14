// NewsTableViewFotoCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NewsTableViewFotoCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var mainNewsImageView: UIImageView!

    // MARK: - Private Properties

    private let service = VKAPIService()

    private var aspectConstraint: NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                mainNewsImageView.removeConstraint(oldValue ?? NSLayoutConstraint())
            }
            if aspectConstraint != nil {
                mainNewsImageView.addConstraint(aspectConstraint ?? NSLayoutConstraint())
            }
        }
    }

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        mainNewsImageView.contentMode = .scaleAspectFit
        mainNewsImageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }

    // MARK: - Public methods

    func configureCell(image: UIImage?) {
        guard let image = image,
              image.size.width > 0 else { return }
        let aspect = image.size.width / image.size.height

        let constraint = NSLayoutConstraint(
            item: mainNewsImageView,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: mainNewsImageView,
            attribute: NSLayoutConstraint.Attribute.height,
            multiplier: aspect,
            constant: 0.0
        )
        constraint.priority = UILayoutPriority(rawValue: 999)
        aspectConstraint = constraint
        mainNewsImageView.image = image
    }
}
