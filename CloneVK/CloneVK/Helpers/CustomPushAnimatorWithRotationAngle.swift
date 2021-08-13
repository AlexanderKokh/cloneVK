// CustomPushAnimatorWithRotationAngle.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CustomPushAnimatorWithRotationAngle: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(
            translationX: source.view.frame.width + (source.view.frame.height - source.view.frame.width) / 2,
            y: -source.view.frame.width / 2
        )
        let rotationAngle = CGAffineTransform(rotationAngle: -.pi / 2)

        destination.view.transform = rotationAngle.concatenating(translation)
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
                            translationX: -(
                                source.view.frame
                                    .width + (source.view.frame.height - source.view.frame.width) / 2
                            ),
                            y: -source.view.frame.width / 2
                        )

                        let rotationAngle = CGAffineTransform(rotationAngle: .pi / 2)
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
                    destination.view.transform = .identity
                    source.view.transform = .identity
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
        )
    }
}
