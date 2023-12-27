//
//  TDDTests.swift
//  TDDTests
//
//  Created by Jonathan Paul on 12/27/23.
//

import XCTest
@testable import TDD

final class TDDTests: XCTestCase {
    func testReadingBookAddsToLibrary() {
        // given
        let bookToBuy = "Great Expectations"
        var user = User()

        // when
        user.buy(bookToBuy)

        // then
        XCTAssertTrue(user.owns(bookToBuy))
    }
}
