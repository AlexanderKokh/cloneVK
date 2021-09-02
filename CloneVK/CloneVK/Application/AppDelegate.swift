// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        print(getDocumentsDirectory())
        FirebaseApp.configure()
        return true
    }

    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
    }
}
