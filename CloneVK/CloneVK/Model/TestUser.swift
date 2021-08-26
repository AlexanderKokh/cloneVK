// TestUser.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель полей для  пользовательских групп в ВК
struct TestUser {
    /// Имя пользователя
    let userName: String
    /// Название картинки аватарки в соц сети
    let userSurname: String
    // let userImageName: String
    let userID: String
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
