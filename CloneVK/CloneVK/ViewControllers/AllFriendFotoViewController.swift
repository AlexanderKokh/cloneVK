// AllFriendFotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

final class AllFriendFotoViewController: UIViewController {
    // MARK: - Public Properties

    var userID = String()

    // MARK: - Private Properties

    private let realm = try? Realm()
    private var notificationToken: NotificationToken?
    private var userPhoto: Results<Photo>?
    private lazy var service = VKAPIService()
    private lazy var contentView = self.view as? AllFriendFotoView

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        bindingViewWithRealm()
        guard let contentView = contentView else { return }
        service.getPhotos(userID: userID) {
            contentView.stopActivityIndicator()
        }
        contentView.createSwipeGesture()
        contentView.navController = navigationController
    }

    private func bindingViewWithRealm() {
        guard let fotos = realm?.objects(Photo.self).filter("userID = %@", userID),
              let contentView = contentView else { return }

        userPhoto = fotos

        notificationToken = userPhoto?.observe { [self] change in
            switch change {
            case .initial:
                break
            case .update:
                contentView.photo = []
                let photos = Array(fotos)
                for photo in photos {
                    contentView.photo.append(self.service.getFoto(image: photo.photo))
                    let photoCount = contentView.photo.count
                    contentView.currentNumberLabel.text = "1 / \(photoCount)"
                    contentView.friendImageView.image = contentView.photo.first
                }
            case let .error(error):
                print(error)
            }
        }
    }
}
