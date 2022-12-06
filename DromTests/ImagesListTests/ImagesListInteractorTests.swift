//
//  ImagesListInteractorTests.swift
//  DromTests
//
//  Created by Izzat on 06.12.2022.
//

import XCTest
@testable import Drom

class ImagesListInteractorTests: XCTestCase {

    // MARK: - Properties

    private var sut: ImagesListInteractor!
    private var presenter: ImagesListPresenterTest!

    // MARK: - Methods

    override func setUp() {
        super.setUp()
        
        let interactor = ImagesListInteractor()
        self.presenter = ImagesListPresenterTest()

        interactor.presenter = self.presenter
        self.sut = interactor
    }

    override func tearDown() {

        self.sut = nil
        self.presenter = nil

        super.tearDown()
    }

    func testLoadInitData() throws {
        self.sut!.loadInitData()
        XCTAssertTrue(self.presenter!.isViewPrepared, "Initial data wasn't loaded")
    }

    func testReloadData() throws {
        self.sut!.reloadData()
        XCTAssertTrue(self.presenter!.isViewReloaded, "Data wasn't reloaded")
    }

    func testStringURLSetter() throws {
        let stringURLs: [String] = ["firstStringURL",
                                    "secondStringURL",
                                    "thirdStringURL",
                                    "fourthStringURL",
                                    "fifthStringURL"]
        self.sut!.stringURLSetter(stringURLs)

        XCTAssertEqual(self.sut!.stringURLs,
                       stringURLs,
                       "Strings URLs aren't equal")
    }

    func testRemoveAtIndex() throws {
        let removingIndex: IndexPath = IndexPath(row: 3, section: 0)
        let stringURLs: [String] = ["firstStringURL",
                                    "secondStringURL",
                                    "thirdStringURL",
                                    "fourthStringURL",
                                    "fifthStringURL"]
        self.sut!.stringURLSetter(stringURLs)
        self.sut!.removeAt(indexPath: removingIndex)

        XCTAssertTrue(self.presenter!.isRemovedAtIndex, "Wasn't deleted at index")
        XCTAssertEqual(self.presenter!.removedIndex,
                       removingIndex,
                       "Removing index and removed index are not equal!")

    }

    func testRemoveAtIndexOutOfRange() throws {
        // Индекс выходит за границы массива, поэтому удалять не нужно
        let removingIndex: IndexPath = IndexPath(row: 15, section: 0)
        let stringURLs: [String] = ["firstStringURL"]
        self.sut!.stringURLSetter(stringURLs)
        self.sut!.removeAt(indexPath: removingIndex)

        XCTAssertFalse(self.presenter!.isRemovedAtIndex, "Was deleted at index, but shouldn't")
    }

    func testRemoveAtIndexAtZero() throws {
        let removingIndex: IndexPath = IndexPath(row: 0, section: 0)
        let stringURLs: [String] = ["firstStringURL"]
        self.sut!.stringURLSetter(stringURLs)
        self.sut!.removeAt(indexPath: removingIndex)

        XCTAssertTrue(self.presenter!.isRemovedAtIndex, "Wasn't deleted at index")
        XCTAssertEqual(self.presenter!.removedIndex,
                       removingIndex,
                       "Removing index and removed index are not equal!")
    }

    func testRemoveAtIndexAtTheLastElement() throws {
        let stringURLs: [String] = ["firstStringURL",
                                    "secondStringURL",
                                    "thirdStringURL",
                                    "fourthStringURL",
                                    "fifthStringURL"]
        let removingIndex: IndexPath = IndexPath(row: stringURLs.count-1, section: 0)
        self.sut!.stringURLSetter(stringURLs)
        self.sut!.removeAt(indexPath: removingIndex)

        XCTAssertTrue(self.presenter!.isRemovedAtIndex, "Wasn't deleted at index")
        XCTAssertEqual(self.presenter!.removedIndex,
                       removingIndex,
                       "Removing index and removed index are not equal!")

    }
}
