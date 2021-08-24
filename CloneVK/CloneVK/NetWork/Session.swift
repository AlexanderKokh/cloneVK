// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Session {
    // MARK: - Public Properties

    static let shared = Session()

    var token = String()
    var userID = Int()

    // MARK: - Initializers

    private init() {}
}
