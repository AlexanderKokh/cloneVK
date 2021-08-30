// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

/// Модель полей  пользователя ВК
final class User: Object {
    /// Имя пользователя
    @objc dynamic var userName = String()
    /// Фамилия пользователя
    @objc dynamic var userSurname = String()
    /// ID пользователя
    @objc dynamic var userID = String()
    /// Путь к аватарке пользователя
    @objc dynamic var userPhoto = String()

    override class func primaryKey() -> String? {
        "userID"
    }

    convenience init(json: JSON) {
        self.init()
        let userName = json["first_name"].stringValue
        let userSurname = json["second_name"].stringValue
        let userID = json["id"].stringValue
        let userPhoto = json["photo_100"].stringValue

        self.userName = userName
        self.userSurname = userSurname
        self.userID = userID
        self.userPhoto = userPhoto
    }
}
