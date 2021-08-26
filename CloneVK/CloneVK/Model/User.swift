// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель полей  пользователя ВК
struct User {
    /// Имя пользователя
    let userName: String
    /// Фамилия пользователя
    let userSurname: String
    /// ID пользователя
    let userID: String
    /// Путь к аватарке пользователя
    let userPhoto: String

    init?(json: JSON) {
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
