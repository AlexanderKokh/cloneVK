// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    let interactiveTransition = CustomInteractiveTransition()

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            if toVC is AllGroupsTableViewController {
                interactiveTransition.viewController = toVC
                return CustomPushAnimator()
            } else {
                return CustomPushAnimatorWithRotationAngle()
            }

        } else if operation == .pop {
            if fromVC is AllGroupsTableViewController {
                if navigationController.viewControllers.first != toVC {
                    interactiveTransition.viewController = toVC
                }
                return CustomPopAnimator()
            } else {
                return CustomPopAnimatorWithRotationAngle()
            }
        }
        return nil
    }
}
