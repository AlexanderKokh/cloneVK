// GroupAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

final class GroupAPIService {
    // MARK: - Public methods

    func getGroups() {
        let opq = OperationQueue()

        let request = getRequest()
        let getDataOperation = GetDataOperation(request: request)
        opq.addOperation(getDataOperation)

        let parseData = ParseData()
        parseData.addDependency(getDataOperation)
        opq.addOperation(parseData)

        let saveToRealm = ReloadTableController()
        saveToRealm.addDependency(parseData)
        OperationQueue.main.addOperation(saveToRealm)
    }

    // MARK: - Private methods

    private func getRequest() -> DataRequest {
        let baseURL = "https://api.vk.com/method/"
        let version = "5.131"
        let token = Session.shared.token

        let path = "groups.get"
        let parameters: Parameters = [
            "v": version,
            "extended": "1",
            "access_token": token
        ]

        let url = (baseURL + path)
        let request = AF.request(url, parameters: parameters)
        return request
    }
}
