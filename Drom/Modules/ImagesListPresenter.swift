//
//  ImagesListPresenter.swift
//  Drom
//
//  Created by Izzat on 06.12.2022.
//

import Foundation

protocol IImagesListPresenter {
    func viewDidAppear(ui: IImagesListView)
}

final class ImagesListPresenter {

    // MARK: - Properties

    private let interactor: IImagesListInteractor
    private let router: IImagesListRouter
    private(set) weak var ui: IImagesListView?

    // MARK: - Init

    init(interactor: IImagesListInteractor, router: IImagesListRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IImagesListPresenter

extension ImagesListPresenter: IImagesListPresenter {
    func viewDidAppear(ui: IImagesListView) {
        self.ui = ui
        self.ui?.cellSelectedAt = { [weak self] (indexPath) in
            self?.interactor.removeAt(indexPath: indexPath)
        }
        self.ui?.refreshControlDidChangedValue = { [weak self] in
            self?.interactor.reloadData()
        }
        self.interactor.loadInitData()
    }
}

// MARK: - IImagesListInteractorOuter

extension ImagesListPresenter: IImagesListInteractorOuter {
    func prepareView(stringURLs: [String]) {
        self.ui?.setupView(stringURLs: stringURLs)
    }

    func removeAt(indexPath: IndexPath) {
        self.ui?.removeCellAt(indexPath: indexPath)
    }

    func reloadView(stringURLs: [String]) {
        self.ui?.reloadCollectionView(stringURLs: stringURLs)
    }
}

