//
//  ImagesListPresenterTests.swift
//  DromTests
//
//  Created by Izzat on 06.12.2022.
//

import XCTest
@testable import Drom

class ImagesListPresenterTests: XCTestCase {
    // MARK: - Properties

    private var sut: ImagesListPresenter!
    private var interactor: ImagesListInteractorTest!
    private var router: ImagesListRouterTest!
    private var ui: ImagesListViewTest!

    // MARK: - Methods

    override func setUp() {
        super.setUp()
        self.interactor = ImagesListInteractorTest()
        self.router = ImagesListRouterTest()
        self.ui = ImagesListViewTest()
        let presenter = ImagesListPresenter(interactor: interactor,
                                            router: router)
        self.sut = presenter
        self.sut!.viewDidAppear(ui: self.ui)
    }

    override func tearDown() {
        self.sut = nil
        self.interactor = nil
        self.router = nil

        super.tearDown()
    }

    func testUISetup() throws {
        XCTAssertNotNil(self.sut!.ui, "Presenter's UI is nil!")
    }

    func testLoadInitData() throws {
        XCTAssertTrue(self.interactor.isInitialDataLoading, "Initial data isn't loading!")
    }


    func testPrepareView() throws {
        let stringURLs: [String] = ["firstStringURL",
                                    "secondStringURL",
                                    "thirdStringURL",
                                    "fourthStringURL",
                                    "fifthStringURL"]
        self.sut!.prepareView(stringURLs: stringURLs)

        XCTAssertTrue(self.ui!.isViewPrepared, "View are not prepared!")
        XCTAssertEqual(self.ui!.stringURLs,
                       stringURLs,
                       "String URLs are not the same!")
    }

    func testReloadView() throws {
        let stringURLs: [String] = ["firstStringURL",
                                    "secondStringURL",
                                    "thirdStringURL",
                                    "fourthStringURL",
                                    "fifthStringURL"]
        self.sut!.reloadView(stringURLs: stringURLs)

        XCTAssertTrue(self.ui!.isCollectionViewReloaded, "View are not reloaded!")
        XCTAssertEqual(self.ui!.stringURLs,
                       stringURLs,
                       "String URLs are not the same!")

    }


    func testRemoveAtIndex() throws {
        let removingIndex = IndexPath(row: 3, section: 0)
        self.sut!.removeAt(indexPath: removingIndex)

        XCTAssertTrue(self.ui!.isCellRemovedAtIndex, "Cell isn't removed at index")
        XCTAssertEqual(self.ui!.removingIndex,
                       removingIndex,
                       "Removing indexes are not the same")
    }
}

