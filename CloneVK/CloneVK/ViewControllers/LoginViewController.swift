// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginTextField: UITextField!

    // MARK: - UIViewController

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotification()
        addGesture()
    }

    override func viewWillDisappear(_ animated: Bool) {
        deleteNotification()
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

    @IBAction func loginAction(_ sender: UIButton) {
        if checkLoginInfo() {
            guard let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(identifier: "TabBarVK") as? UITabBarController else { return }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            showAlert(title: "Авторизация", message: "Неверный логин или пароль")
        }
    }

    // MARK: - Private Properties

    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
    }

    private func addNotification() {
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
    }

    private func deleteNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func checkLoginInfo() -> Bool {
        guard let loginText = loginTextField.text, let pwdText = passwordTextField.text else { return false }
        if loginText == "admin", pwdText == "1234" {
            return true
        } else {
            return false
        }
    }
}
