// AllFriendFotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

final class AllFriendFotoViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var currentNumberLabel: UILabel!
    @IBOutlet private var activitiIndicator: UIActivityIndicatorView!

    // MARK: - Public Properties

    var userID = String()

    // MARK: - Private Properties

    private let realm = try? Realm()
    private var notificationToken: NotificationToken?
    private var userPhoto: Results<Photo>?
    private var index = Int()
    private var photo: [UIImage] = []
    private lazy var service = VKAPIService()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - IBAction

    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                swipe(translationX: -500, increaseIndex: 1)
            case UISwipeGestureRecognizer.Direction.right:
                swipe(translationX: 500, increaseIndex: -1)
            case UISwipeGestureRecognizer.Direction.down:
                swipeDown()
            default:
                break
            }
        }
    }

    // MARK: - Private methods

    private func setupView() {
        bindingViewWithRealm()
        service.getPhotos(userID: userID) { [weak self] in
            self?.activitiIndicator.stopAnimating()
        }
        createSwipeGesture()
    }

    private func createSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
    }

    private func swipe(translationX: Int, increaseIndex: Int) {
        index += increaseIndex
        guard index < photo.count, index >= 0 else {
            index -= increaseIndex
            return
        }
        UIView.animate(
            withDuration: 1,
            animations: {
                let translation = CGAffineTransform(translationX: CGFloat(translationX), y: 0)
                self.friendImageView.transform = translation
                    .concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                self.friendImageView.layer.opacity = 0.2
            },
            completion: { _ in
                self.friendImageView.layer.opacity = 1
                self.friendImageView.transform = .identity
                self.friendImageView.image = self.photo[self.index]
                self.currentNumberLabel.text = "\(self.index + 1) / \(self.photo.count)"
            }
        )
    }

    private func swipeDown() {
        UIView.animate(
            withDuration: 0.7,
            animations: {
                let translation = CGAffineTransform(translationX: 0, y: 1500)
                self.friendImageView.transform = translation
                    .concatenating(CGAffineTransform(scaleX: 0.3, y: 0.3))
            },
            completion: { _ in
                self.navigationController?.popViewController(animated: true)
            }
        )
    }

    private func bindingViewWithRealm() {
        guard let fotos = realm?.objects(Photo.self).filter("userID = %@", userID) else { return }
        userPhoto = fotos

        notificationToken = userPhoto?.observe { change in
            switch change {
            case .initial:
                break
            case .update:
                self.photo = []
                let photos = Array(fotos)
                for photo in photos {
                    self.photo.append(self.service.getFoto(image: photo.photo))
                    let photoCount = self.photo.count
                    self.currentNumberLabel.text = "1 / \(photoCount)"
                    self.friendImageView.image = self.photo.first
                }
            case let .error(error):
                print(error)
            }
        }
    }
}
