// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift
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

    func getGroups() {
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
                let newItems = items.compactMap { Group(json: $0) }
                self.saveGroupsToRealm(newItems)
            case let .failure(error):
                print(error)
            }
        }
    }

    func getPhotos(userID: String, compleation: @escaping () -> ()) {
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
                let friendsPhotos = json["response"]["items"].arrayValue.compactMap { Photo(json: $0, ownerID: userID) }
                self.saveFotosToRealm(userID: userID, friendsPhotos)
                compleation()
            case let .failure(error):
                print(error)
            }
        }
    }

    func getFriends() {
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
                let json = JSON(data)
                let users = json["response"]["items"].arrayValue.compactMap { User(json: $0) }
                self.saveUsersToRealm(users)
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

    // MARK: - Private methods

    private func saveGroupsToRealm(_ groups: [Group]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(Group.self)
            try realm.write {
                realm.delete(oldData)
                realm.add(groups)
            }
        } catch {
            print(error)
        }
    }

    private func saveFotosToRealm(userID: String, _ fotos: [Photo]) {
        do {
            let realm = try Realm()
            let oldFotos = realm.objects(Photo.self).filter("userID = %@", userID)
            try realm.write {
                realm.delete(oldFotos)
                realm.add(fotos)
            }
        } catch {
            print(error)
        }
    }

    private func saveUsersToRealm(_ users: [User]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)

            try realm.write {
                realm.add(users, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
