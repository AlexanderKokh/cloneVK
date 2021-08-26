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

    func groupsSearch(search: String, compleation: @escaping ([Group]) -> ()) {
        let path = "groups.search"
        let parameters: Parameters = [
            "v": version,
            "q": search,
            "access_token": token
        ]

        let url = baseURL + path

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case let .success(data):
                guard let items = try? JSON(data: data)["response"]["items"].arrayValue else { return }
                compleation(items.compactMap { Group(json: $0) })
            case let .failure(error):
                print(error)
            }
        }
    }

    func getGroups(compleation: @escaping ([Group]) -> ()) {
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
                compleation(items.compactMap { Group(json: $0) })
            case let .failure(error):
                print(error)
            }
        }
    }

    func getPhotos(userID: String, compleation: @escaping ([Photo]) -> Void) {
        let path = "photos.get"
        let parameters: Parameters = [
            "v": version,
            "album_id": "profile",
            "owner_id": userID,
            "rev": "1",
            "access_token": token
        ]

        let url = baseURL + path

//        AF.request(url, parameters: parameters).validate().responseData { response in
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                compleation(json)
//            case let .failure(error):
//                print(error)
//            }
//        }

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                let friendsPhotos = json["response"]["items"].arrayValue.compactMap { Photo(json: $0) }
                compleation(friendsPhotos)
            case let .failure(error):
                print(error)
            }
        }
    }

    func getFriends(compleation: @escaping ([User]) -> ()) {
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
                compleation(items.compactMap { User(json: $0) })
            case let .failure(error):
                print(error)
            }
        }
    }

    func getFoto(image: String) -> UIImage {
        guard let imageURL = URL(string: image),
              let data = try? Data(contentsOf: imageURL),
              let image = UIImage(data: data) else { return UIImage() }
        return image
    }
}
