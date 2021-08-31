// AllFriendFotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

final class AllFriendFotoViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var currentNumberLabel: UILabel!

    // MARK: - Public Properties

    var userID = String()

    // MARK: - Private Properties

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
        loadFromRealm()
        loadFromNetwork()
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

    private func loadFromRealm() {
        do {
            let realm = try Realm()
            let realmPhotos = realm.objects(Photo.self).filter("userID = %@", userID)
            let photos = Array(realmPhotos)
            for photo in photos {
                self.photo.append(service.getFoto(image: photo.photo))
                let photoCount = self.photo.count
                currentNumberLabel.text = "1 / \(photoCount)"
                friendImageView.image = self.photo.first
            }
        } catch {
            print(error)
        }
    }

    private func loadFromNetwork() {
        service.getPhotos(userID: userID) { [weak self] in
            self?.photo = []
            self?.loadFromRealm()
        }
    }
}
