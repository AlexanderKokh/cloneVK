// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

/// Модель фотографий пользователей
final class Photo: Object {
    // MARK: - Public Properties

    /// Массив  адресов, по которым хранятся фотографии
    @objc dynamic var photo = String()
    /// ID Пользователя, владельца фотографии
    @objc dynamic var userID = String()

    // MARK: - Initializers

    convenience init(json: JSON, ownerID: String) {
        self.init()
        photo = json["sizes"].arrayValue.last?["url"].stringValue ?? ""
        userID = ownerID
    }
}
