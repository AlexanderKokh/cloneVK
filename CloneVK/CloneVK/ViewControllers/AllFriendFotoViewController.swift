// AllFriendFotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AllFriendFotoViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var currentNumberLabel: UILabel!

    // MARK: - Public Properties

    var userID = String()

    // MARK: - Private Properties

    private var index = Int()
    private var photo: [String] = []

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
        addFotos()
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

    private func addFotos() {
        let service = VKAPIService()

        service.getPhotos(userID: userID) { [weak self] photos in
            let photo = Photo(json: photos)
            self?.photo = photo?.photo ?? []
            guard let photoCount = self?.photo.count else {
                self?.currentNumberLabel.text = "0 / 0"
                return
            }
            self?.currentNumberLabel.text = "1 / \(photoCount)"
            guard let firstPhoto = self?.getFoto(image: self?.photo.first ?? "") else { return }
            self?.friendImageView.image = firstPhoto
        }
    }

    private func getFoto(image: String) -> UIImage {
        guard let imageURL = URL(string: image),
              let data = try? Data(contentsOf: imageURL),
              let image = UIImage(data: data) else { return UIImage() }
        return image
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
                self.friendImageView.image = self.getFoto(image: self.photo[self.index])
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
}
