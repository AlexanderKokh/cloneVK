// LoginVKWebViewController.swift
// Copyright © RoadMap. All rights reserved.

import FirebaseDatabase
import Foundation
import WebKit

final class LoginVKWebViewController: UIViewController {
    // MARK: - Public Properties

    lazy var vkService = VKAPIService()
    // let databaseRef = Database.database().reference().child("User")
    let databaseRef = Database.database().reference(withPath: "User")
    var fireBaseUsers: [String] = []

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
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "\(Session.shared.userID)"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "V", value: "5.68")
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
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

        guard let token = params["access_token"] else { return }

        Session.shared.token = token

        databaseRef.getData { _, snapshot in

            let title = "00000\(Int.random(in: 1 ... 9))"

            if let users = snapshot.value as? [String] {
                self.fireBaseUsers = users
            }
            if !self.fireBaseUsers.contains(title) {
                self.fireBaseUsers.append(title)
                self.databaseRef.setValue(self.fireBaseUsers)
            }
            Session.shared.applicationUserID = title
        }

        decisionHandler(.cancel)
        moveToNextViewController()
    }

    func moveToNextViewController() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "TabBarVK") as? UITabBarController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
