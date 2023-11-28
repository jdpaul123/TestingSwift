//
//  FirstTests.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/28/23.
//

import XCTest
@testable import First

final class FirstTests: XCTestCase {
    func testHaterStartsNicely() {
        // Given
        let hater = Hater()

        // Then
        XCTAssertFalse(hater.hating, "New haters should not be hating")
    }

    // Roy Osherove's naming [UnitOfWork_StateUnderTest_ExpectedBehavior]
    // ex. test_Hater_AfterHavingABadDay_ShouldBeHating
    func testHaterHatesAfterBadDay() {
        // Given || Arrange
        var hater = Hater()

        // When || Act
        hater.hadABadDay()

        // Then || Assert
        XCTAssertTrue(hater.hating)
    }

    func testHaterHappyAfterGoodDay() {
        var hater = Hater()
        hater.hadAGoodDay()
        XCTAssertFalse(hater.hating)

    }
}
