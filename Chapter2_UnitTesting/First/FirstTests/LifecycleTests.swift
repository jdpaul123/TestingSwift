//
//  LifecycleTests.swift
//  FirstTests
//
//  Created by Jonathan Paul on 11/28/23.
//

import XCTest

final class LifecycleTests: XCTestCase {
    override class func setUp() {
        print("In class setUpWithError.")
    }

    override class func tearDown() {
        print("In class tearDown.")
    }

    override func setUp() {
        print("In setUp.")
    }

    override func setUp() async throws {
        print("In setUp async throws.")
    }

    override func setUpWithError() throws {
        print("In setUpWithError throws.")
    }

    // Cannot have this function below in this class when setUp() async throws exists om the same class due to naming problems with Objective-C
//    override func setUp(completion: @escaping (Error?) -> Void) {
//        print("In setUp with completion")
//    }

    override func tearDown() {
        print("In tearDown.")
    }

    // Tear down blocks are used to reset state that is affected in just this one test. Like, deleting data written to a file during the test
    // The last tear down block to be created will be the first to be run after the test completes (Last in, First out like a Stack)
    func testExample() throws {
        print("Starting test.")

        addTeardownBlock {
            print("In first tearDown block.")
        }

        print("In middle of test.")

        addTeardownBlock {
            print("In second tearDown block.")
        }

        print("Finishing test.")
    }
}
