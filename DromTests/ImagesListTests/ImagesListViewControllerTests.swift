//
//  ImagesListViewControllerTests.swift
//  DromTests
//
//  Created by Izzat on 06.12.2022.
//

import XCTest
@testable import Drom

class ImagesListViewControllerTests: XCTestCase {
    // MARK: - Properties

    private var sut: ImagesListViewController!
    private var presenter: ImagesListPresenterTest!

    // MARK: - Methods

    override func setUp() {
        super.setUp()
        self.presenter = ImagesListPresenterTest()
        let viewController = ImagesListViewController(presenter: self.presenter)
        self.sut = viewController
    }

    override func tearDown() {
        self.sut = nil
        self.presenter = nil

        super.tearDown()
    }

    func testViewDidAppear() throws {
        self.sut!.viewDidAppear(true)

        XCTAssertTrue(self.presenter!.isViewAppear, "View didn't appear")
    }
}

