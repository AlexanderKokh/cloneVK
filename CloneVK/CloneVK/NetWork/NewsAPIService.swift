// NewsAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import SwiftyJSON

final class NewsAPIService {
    // MARK: - Private Properties

    private let baseURL = "https://api.vk.com/method/"
    private let version = "5.131"
    private let token = Session.shared.token
    private var postNews: [News] = []
    private var nextFrom: String = ""

    // MARK: - Public methods

    func getNews(
        startTime: TimeInterval? = nil,
        startFrom: String? = nil,
        _ compleation: @escaping ([News], String) -> ()
    ) {
        postNews = []
        let path = "newsfeed.get"
        var parameters: Parameters = [
            "v": version,
            "filters": "post",
            "access_token": token,
            "count": 50
        ]

        if let startTime = startTime {
            parameters["start_time"] = "\(startTime)"
        }

        if let startFrom = startFrom {
            parameters["start_from"] = "\(startFrom)"
        }

        let url = baseURL + path

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case let .success(data):

                let dispatchGroup = DispatchGroup()
                DispatchQueue.global().async(group: dispatchGroup) {
                    self.fillNewsArray(dispatchGroup: dispatchGroup, data: data)
                }
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    compleation(self.postNews, self.nextFrom)
                }

            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Private methods

    private func fillNewsArray(dispatchGroup: DispatchGroup, data: Data) {
        var profiles: [User] = []
        var groups: [Group] = []
        var posts: [Items] = []

        let json = JSON(data)
        profiles = json["response"]["profiles"].arrayValue.compactMap { User(json: $0) }
        groups = json["response"]["groups"].arrayValue.compactMap { Group(json: $0) }
        posts = json["response"]["items"].arrayValue.compactMap { Items(json: $0) }
        nextFrom = json["response"]["next_from"].stringValue

        for post in posts {
            var author = ""
            var avatarURL = ""

            if post.sourseID > 0 {
                guard let profile = profiles.filter({ $0.userID == post.sourseID }).first
                else { return }
                author = "\(profile.userName) \(profile.userSurname)"
                avatarURL = profile.userPhoto
            } else {
                guard let group = groups.filter({ $0.groupID == -post.sourseID }).first else { return }
                author = group.groupName
                avatarURL = group.groupImageName
            }
            addNews(source: post, author: author, avatarURL: avatarURL)
        }
    }

    private func addNews(source: Items, author: String, avatarURL: String) {
        let news = News(
            sourceNews: author,
            sourceImageName: avatarURL,
            sourceText: source.text,
            sourceMainImagename: avatarURL,
            likes: source.likes,
            comments: source.comments,
            views: source.views,
            repost: source.repost,
            photo: source.photo,
            date: source.date
        )
        postNews.append(news)
    }
}
