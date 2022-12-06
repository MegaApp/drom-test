//
//  ImagesListInteractorTest.swift
//  DromTests
//
//  Created by Izzat on 06.12.2022.
//

import Foundation
@testable import Drom

class ImagesListInteractorTest: IImagesListInteractor {

    // MARK: - Properties

    private(set) var isInitialDataLoading: Bool = false
    private(set) var isDataReloaded: Bool = false
    private(set) var isRemovedAtIndex: Bool = false
    private(set) var removingIndex: IndexPath = IndexPath()

    // MARK: - Public methods

    func loadInitData() {
        self.isInitialDataLoading = true
    }

    func reloadData() {
        self.isDataReloaded = true
    }

    func removeAt(indexPath: IndexPath) {
        self.isRemovedAtIndex = true
        self.removingIndex = indexPath
    }
}

