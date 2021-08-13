// InteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public Properties

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGesture(_:))
            )
            recognizer.edges = [.left]

            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var isHasStarted: Bool = false
    var isShouldFinish: Bool = false

    // MARK: - IBAction

    @objc private func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isHasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            isShouldFinish = progress > 0.33
            update(progress)
        case .ended:
            isHasStarted = false
            isShouldFinish ? finish() : cancel()
        case .cancelled:
            isHasStarted = false
            cancel()
        default: return
        }
    }
}
