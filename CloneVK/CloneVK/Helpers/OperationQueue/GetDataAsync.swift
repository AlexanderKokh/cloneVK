// GetDataAsync.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

final class GetDataOperation: AsyncOperation {
    // MARK: - Public Properties

    var data: Data?

    // MARK: - Private Properties

    private var request: DataRequest

    // MARK: - Initializers

    init(request: DataRequest) {
        self.request = request
    }

    override func cancel() {
        request.cancel()
        super.cancel()
    }

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
}
