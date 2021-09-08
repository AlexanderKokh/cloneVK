// GroupAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift
import SwiftyJSON

final class GroupAPIService {
    // MARK: - Private Properties

    private let baseURL = "https://api.vk.com/method/"
    private let version = "5.131"
    private let token = Session.shared.token

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

    private func getRequest() -> DataRequest {
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

/// асинхрон
class AsyncOperation: Operation {
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            "is" + rawValue.capitalized
        }
    }

    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }

    override var isAsynchronous: Bool {
        true
    }

    override var isReady: Bool {
        super.isReady && state == .ready
    }

    override var isExecuting: Bool {
        state == .executing
    }

    override var isFinished: Bool {
        state == .finished
    }

    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }

    override func cancel() {
        super.cancel()
        state = .finished
    }
}

/// асинхрон
class GetDataOperation: AsyncOperation {
    override func cancel() {
        request.cancel()
        super.cancel()
    }

    private var request: DataRequest
    var data: Data?

    init(request: DataRequest) {
        self.request = request
    }

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
}

final class ReloadTableController: Operation {
    override func main() {
        guard let getParseData = dependencies.first as? ParseData else { return }
        let parseData = getParseData.outputData
        do {
            let realm = try Realm()
            let oldData = realm.objects(Group.self)
            try realm.write {
                realm.delete(oldData)
                realm.add(parseData)
            }
        } catch {
            print(error)
        }
    }
}

final class ParseData: Operation {
    var outputData: [Group] = []
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }

        guard let items = try? JSON(data: data)["response"]["items"].arrayValue else { return }
        let newItems = items.compactMap { Group(json: $0) }

        outputData = newItems
    }
}
