// UserImageLikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class UserImageLikeControl: UIControl {
    private var count = Int()
    private var userLikeCountLabel = UILabel()
    private var userLikeImageView = UIImageView()
    private var userImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        userLikeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userLikeImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(userLikeCountLabel)
        addSubview(userLikeImageView)
        addSubview(userImageView)

        createConstraints()
        addGesture()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createConstraints() {
        let userImageViewConstraints = [
            userImageView.leftAnchor.constraint(equalTo: leftAnchor),
            userImageView.rightAnchor.constraint(equalTo: rightAnchor),
            userImageView.topAnchor.constraint(equalTo: topAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 250),
            userImageView.heightAnchor.constraint(equalToConstant: 400),
            userImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ]

        let userLikeImageViewConstraints = [
            userLikeImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            userLikeImageView.heightAnchor.constraint(equalToConstant: 60),
            userLikeImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        let userLikeCountLabelConstraints = [
            userLikeCountLabel.leftAnchor.constraint(equalTo: userLikeImageView.rightAnchor, constant: 10),
            userLikeCountLabel.heightAnchor.constraint(equalToConstant: 60),
            userLikeCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint
            .activate(userImageViewConstraints + userLikeImageViewConstraints + userLikeCountLabelConstraints)
    }

    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onUserImageTap))
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }

    @objc private func onUserImageTap() {
        isSelected = !isSelected
        count += isSelected ? 1 : -1
        updateView()
    }

    private func updateView() {
        userLikeCountLabel.text = "\(count)"
        if isSelected {
            userLikeImageView.image = UIImage(systemName: "heart.fill")
            userLikeImageView.tintColor = .red
        } else {
            userLikeImageView.image = UIImage(systemName: "heart")
            userLikeImageView.tintColor = .black
        }
    }

    func setupUserImage(userImageName: String) {
        userLikeImageView.contentMode = .scaleAspectFit
        userLikeImageView.tintColor = .black
        userLikeImageView.image = UIImage(systemName: "heart")
        userLikeCountLabel.text = "0"
        userImageView.contentMode = .scaleAspectFill
        userImageView.image = UIImage(named: userImageName)
    }
}
