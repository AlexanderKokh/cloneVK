// LoginVKWebViewController.swift
// Copyright © RoadMap. All rights reserved.

import FirebaseDatabase
import Foundation
import WebKit

final class LoginVKWebViewController: UIViewController {
    // MARK: - Public Properties

    lazy var vkService = VKAPIService()

    // MARK: - Private Properties

    private let databaseRef = Database.database().reference().child("User")
    private var fireBaseUsers: [String] = []

    // MARK: - IBOutlet

    @IBOutlet private var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
    }

    // MARK: - Private methods

    private func loadRequest() {
        guard let request = vkService.getAuthRequest() else { return }
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension LoginVKWebViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        guard let token = params["access_token"],
              let userID = params["user_id"] else { return }

        Session.shared.token = token
        Session.shared.applicationUserID = userID

        addUserToFirebase()

        decisionHandler(.cancel)
        moveToNextViewController()
    }

    func addUserToFirebase() {
        databaseRef.getData { [weak self] _, snapshot in
            guard let self = self else { return }
            let userID = Session.shared.applicationUserID

            if let users = snapshot.value as? [String] {
                self.fireBaseUsers = users
            }

            guard !self.fireBaseUsers.contains(userID) else { return }
            self.fireBaseUsers.append(userID)
            self.databaseRef.setValue(self.fireBaseUsers)
        }
    }

    func moveToNextViewController() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "TabBarVK") as? UITabBarController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
