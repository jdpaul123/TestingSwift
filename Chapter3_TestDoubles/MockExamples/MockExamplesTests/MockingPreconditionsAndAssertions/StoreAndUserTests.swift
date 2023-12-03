//
//  StoreAndUserTests.swift
//  MockExamplesTests
//
//  Created by Jonathan Paul on 12/2/23.
//

import XCTest
@testable import MockExamples

class StoreMock: Store {
    var wasAssertionSuccessful = false
    
    override func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
        wasAssertionSuccessful = condition()
    }
}

final class StoreAndUserTests: XCTestCase {
    func testStoreBuyingWithoutUser() {
        // given
        let store = StoreMock()

        // when
        _ = store.buy(product: "War of the Worlds")

        // then
        XCTAssertFalse(store.wasAssertionSuccessful)
    }
}
