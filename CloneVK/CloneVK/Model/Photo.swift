// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель фотографий пользователей
struct Photo {
    /// Массив  адресов, по которым хранятся фотографии
    var photo: [String] = []

    init?(json: JSON) {
        var photoUser: [String] = []
        for photo in json["response"]["items"].arrayValue {
            let photoSizeArray = photo["sizes"].arrayValue
            guard let photo = photoSizeArray.last?["url"].stringValue else { fatalError() }
            photoUser.append(photo)
        }
        photo = photoUser
    }
}
