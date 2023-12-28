//
//  Project1Tests.swift
//  Project1Tests
//
//  Created by Jonathan Paul on 12/27/23.
//

import XCTest
@testable import Project1

class Project1Tests: XCTestCase {
    func testLoadingImages() {
        // given
        let sut = ViewController()

        // when
        sut.loadViewIfNeeded() // make sure the view is loaded fully

        // then
        XCTAssertEqual(sut.pictures.count, 10, "There should be ten pictures.")
    }

    func testTableExists() {
        // given
        let sut = ViewController()

        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertNotNil(sut.tableView)
    }

    func testTableViewHasCorrectRowCount() {
        // given
        let sut = ViewController()
        
        // when
        sut.loadViewIfNeeded()

        // then
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, sut.pictures.count, "There should be 10 rows in the table.")
    }

    func testEachCellHasTheCorrectText() {
        // given
        let sut = ViewController()

        // when
        sut.loadViewIfNeeded()

        // then
        for (index, picture) in sut.pictures.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.textLabel?.text, picture, "The cell should display the correct text.")
        }
    }
    func testEachCellHasDisclosureIndicator() {
        // given
        let sut = ViewController()

        // when
        sut.loadViewIfNeeded()

        // then
        for index in sut.pictures.indices {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.accessoryType, .disclosureIndicator, "The cell should display the correct text.")
        }
    }

    func testViewControllerUsesLargeTitles() {
        // given
        let sut = ViewController()
        _ = UINavigationController(rootViewController: sut) // Inject the view controller into a navigation controller becasue it's part of the storyboard rather than the ViewController

        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertTrue(sut.navigationController?.navigationBar.prefersLargeTitles ?? false)
    }

    func testNavigationBarHasStormViewerTitle() {
        // given
        let sut = ViewController()

        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertEqual(sut.title, "Storm Viewer")
    }
}
