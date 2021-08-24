// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Session {
    // MARK: - Public Properties

    static let shared = Session()

    var token = String()
    var userID = 7_618_150

    // MARK: - Initializers

    private init() {}
}
