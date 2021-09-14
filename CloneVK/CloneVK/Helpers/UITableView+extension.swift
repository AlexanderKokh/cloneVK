// UITableView+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UITableView {
    func showEmptyMessage(_ message: String) {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = message

        backgroundView = label
    }

    func hideEmptyMessage() {
        backgroundView = nil
    }
}
