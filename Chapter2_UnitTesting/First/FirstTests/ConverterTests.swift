//
//  ConverterTests.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/28/23.
//

import XCTest
@testable import First

final class ConverterTests: XCTestCase {
    // sut == system under test
    // sut was defined by Gerard Meszaros according to Paul Hudson

    // Make this optional so that we can create an∂ destory the converter before and after each test repectively
    var sut: Converter!

    override func setUp() {
        sut = Converter()
    }

    override func tearDown() {
        sut = nil
    }

    // Instead of testing 32 to 0 and 212 to 100 in one test we should split them into two tests to avoid any complications from
    // testing two things at once and we can have more specific names for the tests.
    func test32FahrenheitToZeroCelsius() {
        // Given
        let input = 32.0

        // When
        let output = sut.convertToCelsius(fahrenheit: input)

        // Then
        XCTAssertEqual(output, 0, accuracy: 0.000001)
    }

    func test212FahrenheitTo100Celsius() {
        // Given
        let input = 212.0

        // When
        let output = sut.convertToCelsius(fahrenheit: input)
        
        // Then
        XCTAssertEqual(output, 100, accuracy: 0.000001)
    }

    func test100FahrenheitTo37Celcius() {
        // Given
        let input = 100.0

        // When
        let output = sut.convertToCelsius(fahrenheit: input)

        // Then
        XCTAssertEqual(output, 37.77777777777777777777777777777777777, accuracy: 00000000000000000000000000000000001)
        XCTAssertEqual(output, 37.777777, accuracy: 000001)
    }
}
