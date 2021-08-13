// CustomPopAnimatorWithRotationAngle.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CustomPopAnimatorWithRotationAngle: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        2.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        destination.view.frame = source.view.frame

        let rotationAngle = CGAffineTransform(rotationAngle: .pi / 2)
        let translation = CGAffineTransform(
            translationX: -source.view.frame.width / 2,
            y: 3 * source.view.frame.height / 4
        )
        destination.view.transform = translation.concatenating(rotationAngle)
        transitionContext.containerView.addSubview(destination.view)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.5,
                    animations: {
                        let translation = CGAffineTransform(
                            translationX: source.view.frame
                                .width + (source.view.frame.height - source.view.frame.width) / 2,
                            y: -source.view.frame.width / 2
                        )
                        let rotationAngle = CGAffineTransform(rotationAngle: -.pi / 2)

                        source.view.transform = rotationAngle.concatenating(translation)
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 1,
                    animations: {
                        destination.view.transform = .identity
                    }
                )
            }, completion: { finished in
                if finished, !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext
                    .completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
        )
    }
}
