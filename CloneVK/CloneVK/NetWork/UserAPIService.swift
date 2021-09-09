// UserAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import PromiseKit
import RealmSwift
import SwiftyJSON

final class UserAPIService {
    func getFriends() {
        firstly {
            getDataAF()
        }.then { data in
            self.parseData(data: data)
        }.done { user in
            self.saveUsersToRealm(user)
        }.catch { error in
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

    func parseData(data: Data) -> Promise<[User]> {
        Promise<[User]> { resolver in
            let json = JSON(data)
            let users = json["response"]["items"].arrayValue.compactMap { User(json: $0) }
            resolver.fulfill(users)
        }
    }

    func getDataAF() -> Promise<Data> {
        let baseURL = "https://api.vk.com/method/"
        let version = "5.131"
        let token = Session.shared.token

        return Promise<Data> { resolver in
            let path = "friends.get"
            let parameters: Parameters = [
                "v": version,
                "access_token": token,
                "fields": "photo_100",
                "order": "name"
            ]

            let url = (baseURL + path)

            AF.request(url, parameters: parameters).validate().responseData { response in
                guard let data = response.data else { return }
                resolver.fulfill(data)
            }
        }
    }
}
