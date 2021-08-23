// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Session {
    static let shared = Session()

    var token = String()
    var userID = Int()

    private init() {}
}
