// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import SwiftyJSON

final class VKAPIService {
    // MARK: - Private Properties

    private let baseURL = "https://api.vk.com/method/"
    private let version = "5.131"
    private let token = Session.shared.token

    // MARK: - Public methods

    func groupsSearch() {
        let path = "groups.search"
        let parameters: Parameters = [
            "v": version,
            "q": "swift",
            "access_token": token
        ]
        //  getData(path: path, parameters: parameters)
    }

    // MARK: - Private methods

    func getGroups2(compleation: @escaping ([TestGroup]) -> ()) {
        let path = "groups.get"
        let parameters: Parameters = [
            "v": version,
            "extended": "1",
            "access_token": token
        ]

        let url = baseURL + path

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case let .success(data):
                guard let items = try? JSON(data: data)["response"]["items"].arrayValue else { return }
                compleation(items.compactMap { TestGroup(json: $0) })
            case let .failure(error):
                print(error)
            }
        }
    }

    func getPhotos(userID: String, compleation: @escaping (JSON) -> Void) {
        let path = "photos.get"
        let parameters: Parameters = [
            "v": version,
            "album_id": "profile",
            "owner_id": userID,
            "rev": "1",
            "access_token": token
        ]

        let url = baseURL + path

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                compleation(json)
            case let .failure(error):
                print(error)
            }
        }
    }

    func getFriends2(compleation: @escaping ([TestUser]) -> ()) {
        let path = "friends.get"
        let parameters: Parameters = [
            "v": version,
            "access_token": token,
            "fields": "photo_100",
            "order": "name"
        ]

        let url = baseURL + path

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case let .success(data):
                guard let items = try? JSON(data: data)["response"]["items"].arrayValue else { return }
                compleation(items.compactMap { TestUser(json: $0) })
            case let .failure(error):
                print(error)
            }
        }
    }
}
