//
//  DivisionTests.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/29/23.
//

import XCTest
@testable import First

final class DivisionTests: XCTestCase {
    var division: Division!

    override func setUp() {
        division = Division()
    }

    override func tearDown() {
        division = nil
    }

    func test_Division_10DividedBy3_Quotient3Remainder2() {
        // given
        let divided = 10
        let divisor = 3

        // when
        let result = division.divisionRemainder(of: divided, dividedBy: divisor)

        // then
        verifyDivision(result, expectedQuotient: 3, expectedRemainder: 1)
        //verifyDivision(result, expectedQuotient: 3, expectedRemainder: 2) // Uncomment to test the failure fo this test
    }

    // The file and line parameters are default and will be set to the value at the place it is called
    // Including them puts the error message on the line in the test method that failed rather than
    // inside this function implimentation
    func verifyDivision(_ result: (quotient: Int, remainder: Int), expectedQuotient: Int, expectedRemainder: Int,
                        file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(result.quotient, expectedQuotient, file: file, line: line)
        XCTAssertEqual(result.remainder, expectedRemainder, file: file, line: line)
    }

}
