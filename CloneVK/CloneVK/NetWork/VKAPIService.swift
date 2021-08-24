// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

final class VKAPIService {
    let baseURL = "https://api.vk.com/method/"
    let version = "5.131"

    func getFriends() {
        let path = "friends.get"
        let parameters: Parameters = [
            "v": version,
            "access_token": Session.shared.token,
            "fields": "[nickname]"
        ]
        getData(path: path, parameters: parameters)
    }

    func getPhotos() {
        let path = "photos.get"
        let parameters: Parameters = [
            "v": version,
            "album_id": "wall",
            "access_token": Session.shared.token
        ]
        getData(path: path, parameters: parameters)
    }

    func getData(path: String, parameters: Parameters) {
        let url = baseURL + path

        AF.request(url, parameters: parameters).responseJSON { response in
            print(response.value ?? "No Json")
        }
    }
}
