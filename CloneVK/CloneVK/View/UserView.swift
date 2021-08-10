// UserView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@IBDesignable final class UserView: UIView {
    // MARK: - Private Properties

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var cornerRadius: CGFloat = 50.0 {
        didSet {
            updateRadius()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOpacity: Float = .random(in: 0.0 ... 1.0) {
        didSet {
            updateShadowOpacity()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOfsetX: Int = .random(in: 0 ... 20) {
        didSet {
            setNeedsDisplay()
            updateShadowOfsetX()
        }
    }

    @IBInspectable private var shadowOfsetY: Int = .random(in: 0 ... 20) {
        didSet {
            setNeedsDisplay()
            updateShadowOfsetY()
        }
    }

    private let userImageView = UIImageView()
    private let usershadomView = UIView()

    // MARK: - Initializers

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

    // MARK: - Public methods

    func setupImage(imageName: String) {
        if UIImage(named: imageName) != nil {
            userImageView.image = UIImage(named: imageName)
        } else {
            userImageView.image = UIImage(named: "unnamed")
        }
    }

    // MARK: - Private methods

    private func setupView() {
        usershadomView.frame = bounds
        usershadomView.backgroundColor = .white
        addSubview(usershadomView)

        userImageView.frame = bounds
        userImageView.clipsToBounds = true
        addSubview(userImageView)

        addGesture()
    }

    private func updateRadius() {
        userImageView.layer.cornerRadius = cornerRadius
        usershadomView.layer.cornerRadius = cornerRadius
    }

    private func updateShadowOpacity() {
        usershadomView.layer.shadowOpacity = shadowOpacity
    }

    private func updateShadowOfsetX() {
        usershadomView.layer.shadowOffset = CGSize(width: shadowOfsetX, height: shadowOfsetY)
    }

    private func updateShadowOfsetY() {
        usershadomView.layer.shadowOffset = CGSize(width: shadowOfsetX, height: shadowOfsetY)
    }

    private func updateShadowColor() {
        usershadomView.layer.shadowColor = shadowColor.cgColor
        usershadomView.clipsToBounds = false
        usershadomView.layer.shadowOpacity = 1
        usershadomView.layer.shadowOffset = .zero
        usershadomView.layer.shadowRadius = 10
    }

    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onUserImagetap))
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }

    @objc private func onUserImagetap() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 0.8
        animation.duration = 0.7
        animation.repeatCount = 2
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
}
