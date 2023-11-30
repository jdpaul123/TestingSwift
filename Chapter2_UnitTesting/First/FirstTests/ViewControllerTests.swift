//
//  ViewControllerTests.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/29/23.
//

import XCTest

final class ViewControllerTests: XCTestCase {
    /*
     Treat the View Controller as a pipeline. It sends data from one place to the other and then sends updates back the other way if something happened,
     handles View Life Cycle events(ex. viewDidLoad), and contains outlets.

     RULE OF THUMB: "Push as much logic into your model layer as possible." - Brian Gesiak

     Once "import UIKit" is added to a file it becomes harder to test.

     SetUp Tests for a View Controller:
     - Create a "var sut: ViewController" property on the test class
     - Call "sut.loadViewIfNeeded()"
     NOTE: loadViewIfNeeded() loads all of the views from the Story Board attatched to the view controller. Views exist as needed (they are lazy) so
     this method call forces them to load

     Tests to create for a view controller:
     - Manually call lifecycle methods like viewDidLoad() and viewDidAppear(false) to test something like hiding a button based on some state or checking the text of labels
     - Test navigation flow from one ViewController to another with the coordinator pattern when using dependency injection
     - Check that Outlets are connected to the view calling "XCTAssertNotNil(sut.submitButton)"

     Note: checking outlets it part of Smoke Testing
     Smoke Testing: tests that prove the most important functionality works as expected
     */
}
