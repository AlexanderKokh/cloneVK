// AllFriendFotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AllFriendFotoViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var currentNumberLabel: UILabel!

    // MARK: - Private Properties

    private var photos: [UIImage] = []
    private var index = Int()

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
        friendImageView.image = photos.first ?? UIImage()
        currentNumberLabel.text = "1 / \(photos.count)"
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
        photos.append(UIImage(named: "Tim") ?? UIImage())
        photos.append(UIImage(named: "Vlad") ?? UIImage())
        photos.append(UIImage(named: "Ардак") ?? UIImage())
        photos.append(UIImage(named: "Мажит") ?? UIImage())
    }

    private func swipe(translationX: Int, increaseIndex: Int) {
        index += increaseIndex
        guard index < photos.count, index >= 0 else {
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

                self.friendImageView.image = self.photos[self.index]
                self.currentNumberLabel.text = "\(self.index + 1) / \(self.photos.count)"
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
