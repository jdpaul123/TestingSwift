//
//  TestDoubleExampleTests.swift
//  TestDoubleExampleTests
//
//  Created by Jonathan Paul on 12/1/23.
//

import XCTest
@testable import TestDoubleExample

final class TestDoubleExampleTests: XCTestCase {
    func test_TestDoubleExampleUser_tryBuyingApp_fails() {
        // Keep the test double (in this case, the stub) inside of the test
        // You can pull it into the a top-level type once you find your footing
        struct UnreleasedAppStub: AppProtocol {
            var price: Decimal = 0
            var minimumAge = 0
            var isReleased = false

            func canBePurchased(by user: UserProtocol) -> Bool {
                return false
            }
        }
        
        // given
        var sut = User(funds: 100, age: 21, apps: [])
        let app = UnreleasedAppStub()

        // when
        let wasBought = sut.buy(app)

        // then
        XCTAssertFalse(wasBought)
    }
}
