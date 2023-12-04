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
}
