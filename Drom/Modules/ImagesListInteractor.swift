//
//  ImagesListInteractor.swift
//  Drom
//
//  Created by Izzat on 06.12.2022.
//

import Foundation

protocol IImagesListInteractor {
    func loadInitData()
    func reloadData()
    func removeAt(indexPath: IndexPath)
}

protocol IImagesListInteractorOuter: AnyObject {
    func prepareView(stringURLs: [String])
    func removeAt(indexPath: IndexPath)
    func reloadView(stringURLs: [String])
}

final class ImagesListInteractor {

    // MARK: - Properties

    weak var presenter: IImagesListInteractorOuter?
    private(set) var stringURLs: [String] = []
    private let imagesURLManager = ImagesURLManager()

    // MARK: Public method

    func stringURLSetter(_ stringURLs: [String]) {
        self.stringURLs = stringURLs
    }
}

// MARK: - IImagesListInteractor

extension ImagesListInteractor: IImagesListInteractor {
    func loadInitData() {
        self.imagesURLManager.getImagesStringURL(completion: { (stringURLs) in
            self.stringURLSetter(stringURLs)
            self.presenter?.prepareView(stringURLs: stringURLs)
        })
    }

    func removeAt(indexPath: IndexPath) {
        if self.stringURLs.count > indexPath.row {
            self.stringURLs.remove(at: indexPath.row)
            self.presenter?.removeAt(indexPath: indexPath)
        }
    }

    func reloadData() {
        self.imagesURLManager.getImagesStringURL(completion: { (stringURLs) in
            self.stringURLSetter(stringURLs)
            self.presenter?.reloadView(stringURLs: stringURLs)
        })
    }
}

