//
//  PerformanceTesting.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/30/23.
//

import XCTest
@testable import First

final class PerformanceTesting: XCTestCase {
    func testPrimePerformance() {
        // measure causes 10 tests to be done to account for variance in the hardware performance
        /*
         Clicking on the dimond next to self.measure will provide:
         - There was no baseline for the test – Xcode has nothing to compare it again to say whether it
         was faster or slower than expected.
         - The average time shows how long each test run took as a mean average – I got 0.858 seconds.
         - Max STDDEV is how much float from the baseline Xcode is willing to accept before it considers
         the test a failure. The default is 10%, which allows for system conditions to fluctuate just a little.

         Performance testing won’t help you find bugs, and it shouldn’t really be part of your daily test
         suite. However, it can help stop your code from getting progressively worse over time – it’s a
         constant background reminder to looking at your app’s performance from time to time.

         Note: After setting the baseline I had to re-start Xcode to get it to not say "there is no baseline
         set" after every time I ran the test.
         */
        self.measure {
            _ = SynchronousPrimeCalculator.calculate(upTo: 1_000_000)
        }
    }

}
