//
//  ImagesCollectionViewDelegate.swift
//  Drom
//
//  Created by Izzat on 06.12.2022.
//

import UIKit

protocol IImagesCollectionViewDelegate: NSObjectProtocol {
    func selectedCell(indexPath: IndexPath)
}

final class ImagesCollectionViewDelegate: NSObject {

    // MARK: - Properties

    private weak var delegate: IImagesCollectionViewDelegate?

    // MARK: - Init

    init(withDelegate delegate: IImagesCollectionViewDelegate) {
        self.delegate = delegate
    }
}

// MARK: - UICollectionViewDelegate

extension ImagesCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let translationXValue: CGFloat = 3000
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: AppConstants.AnimationTime.collectionViewCellSlideAnimation) {
            cell?.transform = CGAffineTransform(translationX: translationXValue,
                                                y: 0)
        } completion: { _ in
            self.delegate?.selectedCell(indexPath: indexPath)
        }
    }
}

