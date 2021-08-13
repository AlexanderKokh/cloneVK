// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CustomNavigationController: UINavigationController {
    // MARK: - Private Properties

    private let interactiveTransition = CustomInteractiveTransition()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isHasStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            if toVC is AllGroupsTableViewController {
                interactiveTransition.viewController = toVC
                return CustomPushAnimator()
            } else {
                return CustomPushAnimatorWithRotationAngle()
            }
        case .pop:
            if fromVC is AllGroupsTableViewController {
                if navigationController.viewControllers.first != toVC {
                    interactiveTransition.viewController = toVC
                }
                return CustomPopAnimator()
            } else {
                return CustomPopAnimatorWithRotationAngle()
            }
        default:
            return nil
        }
    }
}
