//
//  ImagesListPresenterTest.swift
//  DromTests
//
//  Created by Izzat on 06.12.2022.
//

import Foundation
@testable import Drom

class ImagesListPresenterTest: IImagesListPresenter, IImagesListInteractorOuter {

    // MARK: - Properties

    private(set) var isViewAppear: Bool = false
    private(set) var isViewPrepared: Bool = false
    private(set) var isViewReloaded: Bool = false
    private(set) var isRemovedAtIndex: Bool = false
    private(set) var removedIndex: IndexPath = IndexPath()


    // MARK: - Public methods

    func viewDidAppear(ui: IImagesListView) {
        self.isViewAppear = true
    }

    func prepareView(stringURLs: [String]) {
        self.isViewPrepared = true
    }

    func removeAt(indexPath: IndexPath) {
        self.isRemovedAtIndex = true
        self.removedIndex = indexPath
    }

    func reloadView(stringURLs: [String]) {
        self.isViewReloaded = true
    }
}

