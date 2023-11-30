//
//  CodeCoverageTests.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/30/23.
//

import XCTest
@testable import First

final class CodeCoverageTests: XCTestCase {
    /*
     All three of those lines of code must be run each time we create a House, which means they
     will all be run by the tests above and our code coverage for that initializer is therefore 100%.
     However, we aren’t actually testing those lines: we don’t check that bedrooms and bathrooms are
     actually stored, and we certainly don’t check that cost is calculated correctly.

     if it says code isn’t covered then fine that’s accurate, but if it says code is covered that
     serves as no guarantee that those tests do anything useful.
     */
    func test4Bed2BathHouse_Fits3Bed2BathRequirements() {
        // given
        let house = House(bedrooms: 4, bathrooms: 2)
        let desiredBedrooms = 3
        let desiredBathrooms = 2

        // when
        let suitability = house.checkSuitability(desiredBedrooms: desiredBedrooms, desiredBathrooms: desiredBathrooms)

        // then
        XCTAssertTrue(suitability)
    }
}
