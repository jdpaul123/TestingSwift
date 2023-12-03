//
//  StoreAndUser.swift
//  MockExamples
//
//  Created by Jonathan Paul on 12/2/23.
//

import Foundation

class User {}

class Store {
    var user: User?

    func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), 
                file: StaticString = #file, line: UInt = #line) {
        Swift.assert(condition(), message(), file: file, line: line)
    }

    func buy(product: String) -> Bool {
        assert(user != nil, "We can't buy anything without a user.")
        print("The user bought \(product).")
        return true
    }
}
