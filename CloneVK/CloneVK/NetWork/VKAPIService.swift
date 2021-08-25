// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

final class VKAPIService {
    // MARK: - Private Properties

    private let baseURL = "https://api.vk.com/method/"
    private let version = "5.131"
    private let token = Session.shared.token

    // MARK: - Public methods

    func getFriends() {
        let path = "friends.get"
        let parameters: Parameters = [
            "v": version,
            "access_token": token,
            "fields": "[nickname]"
        ]
        getData(path: path, parameters: parameters)
    }

    func getPhotos() {
        let path = "photos.get"
        let parameters: Parameters = [
            "v": version,
            "album_id": "wall",
            "access_token": token
        ]
        getData(path: path, parameters: parameters)
    }

    func getGroups() {
        let path = "groups.get"
        let parameters: Parameters = [
            "v": version,
            "extended": "1",
            "access_token": token
        ]
        getData(path: path, parameters: parameters)
    }

    func groupsSearch() {
        let path = "groups.search"
        let parameters: Parameters = [
            "v": version,
            "q": "swift",
            "access_token": token
        ]
        getData(path: path, parameters: parameters)
    }

    // MARK: - Private methods

    private func getData(path: String, parameters: Parameters) {
        let url = baseURL + path

        AF.request(url, parameters: parameters).responseJSON { response in
            print(response.value ?? "No Json")
        }
    }
}
