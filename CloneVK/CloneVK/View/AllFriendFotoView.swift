// AllFriendFotoView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// форма экрана отображения всех фотографий выбранного пользователя
class AllFriendFotoView: UIView {
    // MARK: - IBOutlet

    @IBOutlet var friendImageView: UIImageView!
    @IBOutlet var currentNumberLabel: UILabel!
    @IBOutlet var activitiIndicator: UIActivityIndicatorView!

    private var index = Int()
    var photo: [UIImage] = []
    var navController: UINavigationController?

    override func awakeFromNib() {
        super.awakeFromNib()
        activitiIndicator.startAnimating()
        createSwipeGesture()
    }

    func stopActivityIndicator() {
        activitiIndicator.stopAnimating()
    }

    func createSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        addGestureRecognizer(swipeDown)
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
                self.navController?.popViewController(animated: true)
            }
        )
    }

    // MARK: - IBAction

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
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
}
