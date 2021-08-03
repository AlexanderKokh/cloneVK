// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!

    // MARK: - UIViewController

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: - IBAction
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo as NSDictionary?
        let kbSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize?.height ?? 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }

    @IBAction func loginButton(_ sender: UIButton) {
        guard let loginText = loginTextField.text, let pwdText = passwordTextField.text else { return }
        if loginText == "admin", pwdText == "1234" {
            showAlert(title: "Авторизация", message: "Успешно")
        } else {
            showAlert(title: "Авторизация", message: "Неверный логин или пароль")
        }
    }
}
