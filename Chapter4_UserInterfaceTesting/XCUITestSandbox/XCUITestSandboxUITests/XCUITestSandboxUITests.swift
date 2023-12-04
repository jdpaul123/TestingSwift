//
//  XCUITestSandboxUITests.swift
//  XCUITestSandboxUITests
//
//  Created by Jonathan Paul on 12/3/23.
//  Copyright © 2023 Hacking with Swift. All rights reserved.
//

import XCTest

final class XCUITestSandboxUITests: XCTestCase {
    /*
     If you set launch arguments to "enable-testing" then the DEBUG macro will be set to True. You can then configure the app a certain way with code
     in your app using this structure:
     #if DEBUG
     if CommandLine.arguments.contains("enable-testing") {
        configureAppForTesting()
     }
     #endif

     configureAppForTesting() might load some fixed data, for example, so that your test stubs work as expected
     */
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"] // testing flag
        app.launch()
    }

    func testLabelCopiesTextField() {
        let app = XCUIApplication()
        // app.textFields["CopyTextField"].tap() // You can use textFields.element.tap() if there is one text field or use the accessability identifier
        app.textFields.element.tap()

        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.keyboards.buttons["Return"].tap()

        // test goes here
        XCTAssertEqual(app.staticTexts["TextCopy"].label, "test") // "staticTexts" combines text fields and labels values
    }

    func testSliderControlsProgress() {
        let app = XCUIApplication()
        app.sliders["Completion"].adjust(toNormalizedSliderPosition: 1)

        // find the progress view in progressIndicators. It is of type Any? so we must cast it to a string
        guard let completion = app.progressIndicators.element.value as? String else {
            XCTFail("Unable to find the progress indicator.")
            return
        }

        XCTAssertEqual(completion, "0%")
    }

    func testButtonShowAlerts() {
        let app = XCUIApplication()
        app.buttons["Blue"].tap()
        XCTAssertTrue(app.alerts["Blue"].exists)
        XCTAssertTrue(app.alerts["Blue"].isHittable) // exists doesn't always mean it is showing so isHittable confirms it does
        app.alerts["Blue"].buttons["OK"].tap()
    }

    func testSegmentedControlChangesTitle() {
        let app = XCUIApplication()

        // Get the navigation bar's title value
        let navigationBar = app.navigationBars["bobTheBuilder"]
        var title = navigationBar.staticTexts.element.label

        XCTAssertTrue(navigationBar.exists)
        XCTAssertTrue(app.segmentedControls.buttons["Alpha"].isSelected)
        XCTAssertFalse(app.segmentedControls.buttons["Omega"].isSelected)
        XCTAssertEqual(title, "Alpha")

        app.segmentedControls.buttons["Omega"].tap()

        XCTAssertTrue(app.segmentedControls.buttons["Omega"].isSelected)
        XCTAssertFalse(app.segmentedControls.buttons["Alpha"].isSelected)
        title = navigationBar.staticTexts.element.label
        XCTAssertEqual(title, "Omega")
    }
}
