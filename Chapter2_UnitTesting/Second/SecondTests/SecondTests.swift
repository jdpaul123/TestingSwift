//
//  SecondTests.swift
//  SecondTests
//
//  Created by Jonathan Paul on 11/30/23.
//

import XCTest
@testable import Second

/*
 Having test coverage does not mean that line of code was tested
 Having test coverage menas that a line of code in the app was run during the test phase
 In calculating the percent of coverage the function signature and last line with the closing bracket ARE included
 Also, comment lines are included. So it may increase or devrease code coverage if you add in comments depending
 on where you place them
 */
final class SecondTests: XCTestCase {
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
