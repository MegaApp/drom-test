//
//  ImagesCollectionViewDataSource.swift
//  Drom
//
//  Created by Izzat on 06.12.2022.
//

import UIKit

final class ImagesCollectionViewDataSource: NSObject {

    // MARK: Properties

    private var stringURLs: [String] = []

    // MARK: - Методы для работы с stringURLs

    func setData(stringURLs: [String]) {
        self.stringURLs = stringURLs
    }

    func removeAt(indexPath: IndexPath) {
        if self.stringURLs.count > indexPath.row {
            self.stringURLs.remove(at: indexPath.row)
        }
    }
}

// MARK: UICollectionViewDataSource

extension ImagesCollectionViewDataSource: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return stringURLs.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImagesListCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ImagesListCollectionViewCell
        else {
            fatalError("Can't dequeue reusable cell")
        }
        let stringURL = self.stringURLs[indexPath.row]
        cell.setupCell(stringURL: stringURL)
        return cell
    }
}

