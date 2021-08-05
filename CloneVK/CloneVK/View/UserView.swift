// UserView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@IBDesignable final class UserView: UIView {
    private let userImageView = UIImageView()
    private let usershadomView = UIView()

    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
            setNeedsDisplay()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 50.0 {
        didSet {
            updateRadius()
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowOpacity: Float = .random(in: 0.0 ... 1.0) {
        didSet {
            updateShadowOpacity()
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowOfsetX: Int = .random(in: 0 ... 20) {
        didSet {
            setNeedsDisplay()
            updateShadowOfsetX()
        }
    }

    @IBInspectable var shadowOfsetY: Int = .random(in: 0 ... 20) {
        didSet {
            setNeedsDisplay()
            updateShadowOfsetY()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        usershadomView.frame = bounds
        usershadomView.backgroundColor = .white
        addSubview(usershadomView)

        userImageView.frame = bounds
        userImageView.clipsToBounds = true
        addSubview(userImageView)
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

    func setupImage(imageName: String) {
        if UIImage(named: imageName) != nil {
            userImageView.image = UIImage(named: imageName)
        } else {
            userImageView.image = UIImage(named: "unnamed")
        }
    }
}
