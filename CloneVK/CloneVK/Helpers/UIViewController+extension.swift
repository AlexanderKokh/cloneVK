// UIViewController+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: UIViewController

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    func showAlertCompleation(title: String, message: String?, compleation: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            compleation()
        }
        alert.addAction(alertAction)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(alertActionCancel)
        present(alert, animated: true)
    }
}
