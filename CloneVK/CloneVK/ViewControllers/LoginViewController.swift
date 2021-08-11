// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginTextField: UITextField!

    // MARK: - Private Properties

    private var firstDote = UIView()
    private var secondDote = UIView()
    private var thirdDote = UIView()

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
            continueLogin()
        } else {
            showAlert(title: "Ошибка авторизации", message: "Неверный логин и/или пароль")
        }
    }

    // MARK: - Private Properties

    private func continueLogin() {
        startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.firstDote.layer.removeAllAnimations()
            self.secondDote.layer.removeAllAnimations()
            self.thirdDote.layer.removeAllAnimations()

            guard let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(identifier: "TabBarVK") as? UITabBarController else { return }
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
        }
    }

    private func setupSubView(newView: UIView, xPosition: Int) -> UIView {
        newView.backgroundColor = .black
        newView.alpha = 0
        newView.frame = CGRect(x: view.center.x + CGFloat(xPosition), y: view.center.y, width: 10, height: 10)
        view.addSubview(newView)
        newView.layer.cornerRadius = 5
        return newView
    }

    private func startAnimation() {
        firstDote = setupSubView(newView: firstDote, xPosition: -15)
        secondDote = setupSubView(newView: secondDote, xPosition: 0)
        thirdDote = setupSubView(newView: thirdDote, xPosition: 15)

        UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat, .autoreverse]) {
            self.firstDote.alpha = 1
        }

        UIView.animate(withDuration: 0.7, delay: 0.3, options: [.repeat, .autoreverse]) {
            self.secondDote.alpha = 1
        }

        UIView.animate(withDuration: 0.7, delay: 0.6, options: [.repeat, .autoreverse]) {
            self.thirdDote.alpha = 1
        }
    }

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
