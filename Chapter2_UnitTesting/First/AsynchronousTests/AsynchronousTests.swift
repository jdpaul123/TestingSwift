//
//  AsynchronousTests.swift
//  AsynchronousTests
//
//  Created by Jonathan Paul on 11/29/23.
//

import XCTest

// Sieve of Eratosthenes: Calculates Prime Numbers Up To A Maximum Number
// Easy to do on main thread when max is 100_000, but app will drop frames if its a large number like one million or billion so we multithread it
struct PrimeCalculator {
    // NOTE: Rather than return the array we use a completion to deal with the resulting array of prime numbers
    static func calculate(upTo max: Int, completion: @escaping ([Int]) -> Void) {
        // push our work straight to a background thread
        DispatchQueue.global().async {
            guard max > 1 else {
                // if the input value is 0 or 1 exit immediately
                return
            }
            // mark all our numbers as prime
            var sieve = [Bool](repeating: true, count: max)

            // 0 and 1 are by definition not prime
            sieve[0] = false
            sieve[1] = false

            // count from 0 up to the ceiling...
            for number in 2..<max {
                // if this is marked as prime, then every multiple of it is not prime
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) { // TODO: I see how this is more efficient, but wouldn't starting at number*2 work? I guess there is some mathematical reason why we can start at number * number: like anything before is covered by some earlier number value that has already switched number * 2 to false?
                        sieve[multiple] = false
                    }
                }
            }

            // collapse our results down to a single array of primes
            let primes = sieve.enumerated().compactMap { $1 == true ? $0 : nil } // $1 is the value in the array and $0 is the index in the array
            completion(primes)
        }
    }

    static func calculateStreaming(upTo max: Int, completion: @escaping (Int) -> Void) {
        // push our work straight to a background thread
        DispatchQueue.global().async {
            guard max > 1 else {
                // if the input value is 0 or 1 exit immediately
                return
            }
            // mark all our numbers as prime
            var sieve = [Bool](repeating: true, count: max)

            // 0 and 1 are by definition not prime
            sieve[0] = false
            sieve[1] = false

            // count from 0 up to the ceiling...
            for number in 2..<max {
                // if this is marked as prime, then every multiple of it is not prime
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                    completion(number)
                }
            }
        }
    }

    static func calculateWithProgress(upTo max: Int, completion: @escaping ([Int]) -> Void) -> Progress {
        // create a Progress object that counts up to our maximum number
        let progress = Progress(totalUnitCount: Int64(max))

        DispatchQueue.global().async {
            guard max > 1 else {
                completion([])
                return
            }

            var sieve = [Bool](repeating: true, count: max)
            sieve[0] = false
            sieve[1] = false

            // add 2 to our progress counter, because we already went through 0 and 1
            progress.completedUnitCount += 2

            for number in 2..<max {
                // every time we've checked one number, add 1 to our completed unit count
                progress.completedUnitCount += 1

                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                }
            }

            let primes = sieve.enumerated().compactMap { (index, value) in
                value == true ? index : nil
            }
            completion(primes)
        }

        // send back the Progress object
        return progress
    }
}


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
