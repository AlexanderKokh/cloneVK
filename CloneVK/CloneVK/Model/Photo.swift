// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

/// Модель фотографий пользователей
final class Photo: Object {
    /// Массив  адресов, по которым хранятся фотографии

    @objc dynamic var photo = String()
    @objc dynamic var userID = String()

    convenience init(json: JSON, ownerID: String) {
        self.init()
        photo = json["sizes"].arrayValue.last?["url"].stringValue ?? ""
        userID = ownerID
    }
}
