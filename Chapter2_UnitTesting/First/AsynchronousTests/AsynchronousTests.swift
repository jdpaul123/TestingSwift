//
//  AsynchronousTests.swift
//  AsynchronousTests
//
//  Created by Jonathan Paul on 11/29/23.
//

import XCTest
@testable import First

final class AsynchronousTests: XCTestCase {
    /*
     Asynchronous Tests break 2 of the FIRST rules:
     - They are not fast (ex. running network calls, calling wait() for expectations that are seconds long)
     - They are often unreliable (ex. relying on an internet connection)

     For production code disable AsynchronousTests in the Scheme so that the async tests don't run every time you press Cmd+U.
     Steps:
     Product menu -> Scheme -> Edit Scheme -> Choose Test form the left-hand list of options ->
     Open the autocreated test plan for the app -> uncheck Enabled next to AsynchronousTests
     */

    /*
     Expectations:
     If we did not include the expectation parameter and wait() then "XCTAssertEqual($0.count, 25)" would never be checked
     because "PrimeCalculator.calculate()" would not have enough time to finish it's work and trigger the closure with the
     XCAssertEqual() call in it.

     We wait to hit the expectation.fulfill() method for up to 10 seconds to allow .calculate() to finish and trigger the
     closure that does the XCTAssertEqual() check.

     We use the expectation in this test to tell XCTest that we care about the completion block
     so wait up to 10 seconds for the expectation in the completion to be fullfilled before continuing the test, which,
     in this case, would mean the test ending
     */
    func testPrimesUpTo100ShouldBe25() {
        // given
        let maximumCount = 100
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")

        // when
        PrimeCalculator.calculate(upTo: maximumCount) {
            // then
            XCTAssertEqual($0.count, 25)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10) // timeout is measured in seconds so this is 10 seconds
    }

    /*
     Advanced expectations:
     - set "expectation.isInverted = true" to make it so the test fails if the "expectation.fulfill()" is called before the "wait(for: [expectation)" ends
     - set "expectation.expectedFulfillmentCount = 25" to make it so the expectation is not fulfilled until it "expectation.fulfill()" is called 25 times
     - set "expectation.assertForOverFulfill = true" to true which causes the test to both pass and crash if the exception is fulfilled more
     than the expected count which defaults to 1. This property is false by default.
     */

    // One drawback of this is that when it fails it just says that the expectation was never fulfilled rather than pointing to the XCTAssert that failed
    func test_PrimeCalculator_calculateStreaming_input100_shouldBe25() {
        // given
        let maximumCount = 100
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")
        expectation.expectedFulfillmentCount = 25

        // when
        PrimeCalculator.calculateStreaming(upTo: maximumCount) { primeNumber in
            // then
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    // This has the added benefit of checking that they come back in the right order
    func testPrimesUpTo100ShouldBe25_thorough() {
        // given
        let maximumCount = 100
        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        var primeCounter = 0

        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")
        expectation.expectedFulfillmentCount = 25

        // when
        PrimeCalculator.calculateStreaming(upTo: maximumCount) { number in
            XCTAssertEqual(primes[primeCounter], number)
            expectation.fulfill()
            primeCounter += 1
        }

        wait(for: [expectation], timeout: 3)
    }

    func testPrimesUpTo100ShouldBe25_withProgress() {
        // given
        let maximumCount = 100

        // when
        let progress = PrimeCalculator.calculateWithProgress(upTo: maximumCount) { primes in
            XCTAssertEqual(primes.count, 25)
        }

        // then
        let predicate = NSPredicate(format: "%@.completedUnitCount == %@", argumentArray: [progress, maximumCount])

        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: progress)
        wait(for: [expectation], timeout: 10)
    }
}
