// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
import SwiftyJSON

/// Модель полей для  пользовательских групп в ВК
final class Group: Object {
    // MARK: - Public Properties

    /// Название группы
    @objc dynamic var groupName = String()
    /// Название оснвной картинки группы
    @objc dynamic var groupImageName = String()

    // MARK: - Initializers

    convenience init(json: JSON) {
        self.init()
        let groupName = json["name"].stringValue
        let groupImageName = json["photo_100"].stringValue
        self.groupName = groupName
        self.groupImageName = groupImageName
    }

    convenience init(groupName: String, groupImageName: String) {
        self.init()
        self.groupName = groupName
        self.groupImageName = groupImageName
    }
}
