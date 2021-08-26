// TestGroup.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель полей для  пользовательских групп в ВК
struct TestGroup {
    /// Название группы
    let groupName: String
    /// Название оснвной картинки группы
    let groupImageName: String

    init?(json: JSON) {
        let groupName = json["name"].stringValue
        let groupImageName = json["photo_100"].stringValue
        self.groupName = groupName
        self.groupImageName = groupImageName
    }

    init(groupName: String, groupImageName: String) {
        self.groupName = groupName
        self.groupImageName = groupImageName
    }
}
