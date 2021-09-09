// SaveGroupsRealm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

final class ReloadTableController: Operation {
    // MARK: - Initializers

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
