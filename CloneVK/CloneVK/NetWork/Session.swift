// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Session {
    // MARK: - Public Properties

    static let shared = Session()

    var token = String()
    var userID = 7_950_722
    var applicationUserID = String()

    // MARK: - Initializers

    private init() {}
}
