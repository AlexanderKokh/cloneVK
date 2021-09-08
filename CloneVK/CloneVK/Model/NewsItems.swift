// NewsItems.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель для заполнения данными ленты новостей
struct Items {
    // MARK: - Public Properties

    /// Дата публикации новости
    var date = String()
    /// ID источника новости(группа или пользователь)
    var sourseID = Int()
    /// Текст новости
    var text = String()
    /// Количество просмотров
    var views = String()
    /// Количество лайков
    var likes = String()
    /// Количество репостов
    var repost = String()
    /// Количество комментариев
    var comments = String()
    /// фотография, прикрепленная к новости
    var photo = String()

    // MARK: - Initializers

    init(json: JSON) {
        let date = json["date"].stringValue
        let sourseID = json["source_id"].intValue
        let text = json["text"].stringValue
        let views = json["views"]["count"].stringValue
        let likes = json["likes"]["count"].stringValue
        let repost = json["reposts"]["count"].stringValue
        let comments = json["comments"]["count"].stringValue
        let photo = json["attachments"].arrayValue.first?["photo"]["sizes"].arrayValue.last?["url"].stringValue

        self.date = date
        self.sourseID = sourseID
        self.text = text
        self.views = views
        self.likes = likes
        self.repost = repost
        self.comments = comments
        self.photo = photo ?? ""
    }
}
