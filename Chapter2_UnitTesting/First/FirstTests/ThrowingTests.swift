//
//  ThrowingTests.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/29/23.
//

// Handling Errors

import XCTest

enum GameError: Error {
    case notPurchased
    case notInstalled
    case parentalControlsDisallowed
}

struct Game {
    let name: String

    func play() throws {
        if name == "BioBlitz" {
            throw GameError.notPurchased
//            throw NSError() // Use this to test testPlayingBioBlitzThrows hits the final catch
//            throw GameError.notInstalled // Use this to test testPlayingBioBlitz catches on "catch as GameError"
        } else if name == "Blastazap" {
            throw GameError.notInstalled
        } else if name == "Dead Storm Rising" {
            throw GameError.parentalControlsDisallowed
        } else {
            print("\(name) is OK to play!")
        }
    }
}

final class ThrowingTests: XCTestCase {
    // MARK: Catching Errors In Tests
    // If the play method gets run and does not throw an error then the XCTFail function will get hit
    // to test that playing BioBlitz will cause an error to be thrown
    func testPlayingBioBlitzThrows() {
        // Given
        let game = Game(name: "BioBlitz")

        do {
            // When
            try game.play()
            // Then (this is not exactly a "Then" because ideally it doesn't get hit)
            XCTFail("BioBlitz has not been purchased.")
        } catch GameError.notPurchased {
            // Then (this is not exactly a "Then" because it should hit this, but it might not if the test fails)
            // SUCCESS!
        } catch is GameError {
            XCTFail("The error is the wrong type of GameError")
        } catch {
            // Then (this is not exactly a "Then" because ideally it doesn't get hit)
            XCTFail("Playing BioBlitz did not produce the right error.")
        }
    }

    // MARK: Asserting Throws
    func testPlayingBlastazapThrows() {
        let game = Game(name: "Blastazap")
        XCTAssertThrowsError(try game.play())
    }

    func testPlayingBlastazapThrowsNotInstalledError() {
        let game = Game(name: "Blastazap")
        XCTAssertThrowsError(try game.play()) { error in
            XCTAssertEqual(error as? GameError, GameError.notInstalled)
        }
    }

    func testPlayingExplodingMonkeysDoesntThrow() {
        let game = Game(name: "Monkeys")
        XCTAssertNoThrow(try game.play())
    }

    func testDeadStormRisingThrows() {
        let game = Game(name: "Dead Storm Rising")
        XCTAssertThrowsError(try game.play()) { error in
            XCTAssertEqual(error as? GameError, GameError.parentalControlsDisallowed)
        }
    }

    // MARK: Throwing Tests
    // Throwing tests are good for testing throwing functions that are designed to not throw.
    // This isn't a great way to test Dead Storm Rising because it will always fail
//    func testDeadStormRisingThrows() throws {
//        let game = Game(name: "Dead Storm Rising")
//        try game.play()
//    }

    func testCrashyPlaneDoesntThrow() throws {
        let game = Game(name: "Crashy Plane")
        try game.play()
    }
}
