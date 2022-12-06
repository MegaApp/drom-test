//
//  ImagesListViewTest.swift
//  DromTests
//
//  Created by Izzat on 06.12.2022.
//

import Foundation
@testable import Drom

class ImagesListViewTest: IImagesListView {

    // MARK: - Properties

    var cellSelectedAt: ((IndexPath) -> Void)?
    var refreshControlDidChangedValue: (() -> Void)?

    private(set) var isViewPrepared: Bool = false
    private(set) var isCellRemovedAtIndex: Bool = false
    private(set) var removingIndex: IndexPath = IndexPath()
    private(set) var isCollectionViewReloaded: Bool = false
    private(set) var stringURLs: [String] = []

    // MARK: - Public methods

    func setupView(stringURLs: [String]) {
        self.isViewPrepared = true
        self.stringURLs = stringURLs
    }

    func removeCellAt(indexPath: IndexPath) {
        self.isCellRemovedAtIndex = true
        self.removingIndex = indexPath
    }

    func reloadCollectionView(stringURLs: [String]) {
        self.isCollectionViewReloaded = true
        self.stringURLs = stringURLs
    }
}

