// FriendsCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FriendsCollectionViewController: UICollectionViewController {
    // MARK: - Public Properties

    var userImage = ""

    // MARK: - Private Properties

    private let reuseIdentifier = "UserCollectionViewCell"

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize = CGSize(width: 200, height: 200)
    }

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
