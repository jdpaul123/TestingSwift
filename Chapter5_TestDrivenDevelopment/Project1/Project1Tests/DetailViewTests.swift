//
//  DetailViewTests.swift
//  Project1Tests
//
//  Created by Jonathan Paul on 12/28/23.
//

import XCTest
@testable import Project1

final class DetailViewTests: XCTestCase {
    func testDetailImageViewExists() {
        // given
        let sut = DetailViewController()

        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertNotNil(sut.imageView)
    }

    func testDetailViewIsImageView() {
        // given
        let sut = DetailViewController()

        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertEqual(sut.view, sut.imageView)
    }

    func testDetailLoadsImage() {
        // given
        let filenameToTest = "nssl0049.jpg"
        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)

        let sut = DetailViewController()
        sut.selectedImage = filenameToTest

        // when
        sut.loadViewIfNeeded()

        // then
        XCTAssertEqual(sut.imageView.image, imageToLoad)
    }

    // MARK: Integration test with View Controller
//    func testSelectingImageShowsDetail() {
//        // given
//        let sut = ViewController()
//        let navigationController = UINavigationController(rootViewController: sut)
//        let testIndexPath = IndexPath(row: 0, section: 0)
//
//        // when
//        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
//
//        // create an expectation because the didSelectRowAt method happens after all
//        // code in the current view controller is finshed. Creating an expectation
//        // that gets hit on the main queue will happen right after loading
//        // the new view
//        let expectation = XCTestExpectation(description: "Selected a table view cell.")
//
//        // ...then fulfil the expectation on the main queue asynchronously
//        DispatchQueue.main.async {
//            expectation.fulfill()
//        }
//
//        // then
//        wait(for: [expectation], timeout: 1) // timeout of 1 is redundant because the expectation will be fullfilled in the next runloop
//        XCTAssertTrue(navigationController.topViewController is DetailViewController)
//    }

    func testSelectingImageShowsDetail() {
        // given
        let sut = ViewController()
        var selectedImage: String?
        let testIndexPath = IndexPath(row: 0, section: 0)

        // when
        sut.pictureSelectAction = {
            selectedImage = $0
        }
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)

        // then
        XCTAssertEqual(selectedImage, "nssl0049.jpg")
    }

    // Combining testDetailLoadsImage() and testSelectingImageShowsDetail()
//    func testSelectingImageShowsDetailImage() {
//        // given
//        let sut = ViewController()
//        let navigationController = UINavigationController(rootViewController: sut)
//        let testIndexPath = IndexPath(row: 0, section: 0)
//        let filenameToTest = "nssl0049.jpg"
//        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)
//
//        // when
//        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
//        let expectation = XCTestExpectation(description: "Selected a table view cell.")
//
//        DispatchQueue.main.async {
//            expectation.fulfill()
//        }
//
//        // then
//        wait(for: [expectation], timeout: 1)
//        guard let detail = navigationController.topViewController as? DetailViewController else {
//            XCTFail("Didn't push to a detail view controller.")
//            return
//        }
//
//        detail.loadViewIfNeeded()
//
//        XCTAssertEqual(detail.imageView.image, imageToLoad)
//    }

    func testSelectingImageShowsDetailImage() {
        // given
        let sut = ViewController()
        let testIndexPath = IndexPath(row: 0, section: 0)
        let filenameToTest = "nssl0049.jpg"

        let imageToLoad = UIImage(named: filenameToTest, in: Bundle.main, compatibleWith: nil)

        // when
        sut.pictureSelectAction = {
            let detail = DetailViewController()
            detail.selectedImage = $0
            detail.loadViewIfNeeded()
            XCTAssertEqual(detail.imageView.image, imageToLoad)
        }
        sut.tableView(sut.tableView, didSelectRowAt: testIndexPath)
    }
}
