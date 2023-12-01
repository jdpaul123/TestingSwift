//
//  App.swift
//  TestDoubleExample
//
//  Created by Jonathan Paul on 12/1/23.
//

import Foundation

protocol AppProtocol {
    var price: Decimal { get set }
    var minimumAge: Int { get set }
    var isReleased: Bool { get set }

    func canBePurchased(by user: UserProtocol) -> Bool
    static func printTerms()
}

// You can give a default implementation using a protocol extension so that we don't need to add it to our types and stubs unless we specifically want it.
// To call a static method on an object that has the type of a protocol, you use the type(of:) function to get the type and call the static method.
extension AppProtocol {
    static func printTerms() {
        print("Here are 50 pages of terms and conditions for you to read on a tiny phone screen.")
    }
}

struct App: AppProtocol {
    var price: Decimal
    var minimumAge: Int
    var isReleased: Bool

    func canBePurchased(by user: UserProtocol) -> Bool {
        guard isReleased else {
            return false
        }

        guard user.funds >= price else {
            return false
        }

        if user.age >= minimumAge {
            return true
        } else {
            return false
        }
    }
}
