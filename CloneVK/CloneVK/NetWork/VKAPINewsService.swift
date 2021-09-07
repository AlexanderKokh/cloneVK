// VKAPINewsService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import SwiftyJSON

final class VKAPINewsService {
    // MARK: - Private Properties

    private struct Profiles {
        /// Имя пользователя
        var userName = String()
        /// Фамилия пользователя
        var userSurname = String()
        /// ID пользователя
        var id = Int()
        /// Путь к аватарке пользователя
        var userPhoto = String()

        // MARK: - Initializers

        init(json: JSON) {
            let userName = json["first_name"].stringValue
            let userSurname = json["last_name"].stringValue
            let id = json["id"].intValue
            let userPhoto = json["photo_100"].stringValue

            self.userName = userName
            self.userSurname = userSurname
            self.id = id
            self.userPhoto = userPhoto
        }
    }

    private struct NewsGroups {
        var name = String()
        var groupID = Int()
        var groupPhoto = String()

        init(json: JSON) {
            let name = json["name"].stringValue
            let groupID = json["id"].intValue
            let photo = json["photo_100"].stringValue

            self.name = name
            self.groupID = groupID
            groupPhoto = photo
        }
    }

    private struct Items {
        var date = String()
        var sourseID = Int()
        var text = String()
        var views = String()
        var likes = String()
        var repost = String()
        var comments = String()
        var photo = String()

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

    private let baseURL = "https://api.vk.com/method/"
    private let version = "5.131"
    private let token = Session.shared.token

    // MARK: - Public methods

    func getNews(_ compleation: @escaping ([News]) -> ()) {
        let path = "newsfeed.get"
        let parameters: Parameters = [
            "v": version,
            "filters": "post",
            "access_token": token
        ]

        let url = baseURL + path

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let dispatchGroup = DispatchGroup()

                var postNews: [News] = []
                var profiles: [Profiles] = []
                var groups: [NewsGroups] = []
                var posts: [Items] = []

                DispatchQueue.global().async(group: dispatchGroup) {
                    let json = JSON(data)
                    profiles = json["response"]["profiles"].arrayValue.compactMap { Profiles(json: $0) }
                    groups = json["response"]["groups"].arrayValue.compactMap { NewsGroups(json: $0) }
                    posts = json["response"]["items"].arrayValue.compactMap { Items(json: $0) }

                    DispatchQueue.global().async(group: dispatchGroup) {
                        for post in posts {
                            var author = ""
                            var avatarURL = ""

                            if post.sourseID > 0 {
                                guard let profile = profiles.filter({ $0.id == post.sourseID }).first else { return }
                                author = "\(profile.userName) \(profile.userSurname)"
                                avatarURL = profile.userPhoto
                            } else {
                                guard let group = groups.filter({ $0.groupID == -post.sourseID }).first else { return }
                                author = group.name
                                avatarURL = group.groupPhoto
                            }
                            let news = News(
                                sourceNews: author,
                                sourceImageName: avatarURL,
                                sourceText: post.text,
                                sourceMainImagename: avatarURL,
                                likes: post.likes,
                                comments: post.comments,
                                views: post.views,
                                repost: post.repost,
                                photo: post.photo
                            )
                            postNews.append(news)
                        }
                    }
                }

                dispatchGroup.notify(queue: DispatchQueue.main) {
                    compleation(postNews)
                }

            case let .failure(error):
                print(error)
            }
        }
    }
}
