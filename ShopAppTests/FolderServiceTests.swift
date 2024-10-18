//
//  FolderServiceTests.swift
//  ShopAppTests
//
//  Created by Василий on 30.09.2024.
//

import XCTest
@testable import ShopApp

final class FolderServiceTests: XCTestCase {

    // MARK: - Properties

    var service: FolderProvider!

    // MARK: - Instance methods

    override func setUp() {
        super.setUp()

        self.service = FolderProviderImpl()

    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

//    func testAddingFolderWithSameName() {
//        ser
//        service.foldersForSave.removeAll()
//        service.addFolder(name: "Все")
//        XCTAssertEqual(service.foldersForSave.count, 0)
//    }
}
