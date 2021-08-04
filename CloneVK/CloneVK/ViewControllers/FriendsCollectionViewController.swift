// FriendsCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

private let reuseIdentifier = "UserCollectionViewCell"

let userImage = "Матвей"

final class FriendsCollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 200, height: 200)
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UserCollectionViewCell
        else { fatalError() }
        cell.configureCell(userImageName: userImage)
        return cell
    }
}
