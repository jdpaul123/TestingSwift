//
//  House.swift
//  Second
//
//  Created by Jonathan Paul on 11/30/23.
//

import Foundation

struct House {
    var bedrooms: Int
    var bathrooms: Int
    var cost: Int

    init(bedrooms: Int, bathrooms: Int) {
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.cost = bedrooms * bathrooms * 50_000
    }

    func checkSuitability(desiredBedrooms: Int, desiredBathrooms: Int) -> Bool {
        // The && below causes "implicit closure #1 in House.checkSuitability(desiredBedrooms:desiredBathrooms:)" to exist
        // when we look at the Coverage report in the report navigator. The report navigator is the last option in the
        // navigator list on the left panel of XCode; to the right of the breakpoint navigator
        // In the standard library && is defined by this function:
        /*
         public static func && (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
             return lhs ? try rhs() : false
         }
         */
        // Instead of the rhs being of type Bool it is an autoclosure. This wraps the bool in a closure that only gets
        // called if the lhs is true. We don't evaluate the right hand side because we don't have to thus making the &&
        // operator faster. 
        // The || operator is the same way. If we change the line below to || we get 0% coverage instead
        // of 100% coverage on the "implicit closure #1...". This is because the lhs will be true so we don't need to
        // know if the rhs is true or false so the rhs autoclosure never gets evaluated
        if bedrooms >= desiredBedrooms && bathrooms >= desiredBathrooms {
            return true
        } else {
            return false
        }
    }
}
