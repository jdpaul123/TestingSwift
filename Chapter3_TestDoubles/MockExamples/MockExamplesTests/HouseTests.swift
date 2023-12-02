//
//  MockExamplesTests.swift
//  MockExamplesTests
//
//  Created by Jonathan Paul on 12/2/23.
//

import XCTest
@testable import MockExamples

final class HouseMock: HouseProtocol {
    var numberOfViewings = 0

    func conductViewing() {
        // Rather than boolean values, an integer lets us test if we measured precisely 0, 1 or more than 1 calls
        numberOfViewings += 1
    }
}

final class HouseTests: XCTestCase {
    func testViewingHouseAddsOneToViewings() {
        // given
        let buyer = Buyer()
        let house = HouseMock()
        // Keep track of startViewings so we don't test against the absolute value of viewings, but rather the relative value
        let startViewings = house.numberOfViewings

        // when
        buyer.view(house)

        // then
        XCTAssertEqual(house.numberOfViewings, startViewings + 1)
    }
}
