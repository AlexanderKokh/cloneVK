// ParseData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

final class ParseData: Operation {
    // MARK: - Public Properties

    var outputData: [Group] = []

    // MARK: - Initializers

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }

        guard let items = try? JSON(data: data)["response"]["items"].arrayValue else { return }
        let newItems = items.compactMap { Group(json: $0) }

        outputData = newItems
    }
}
