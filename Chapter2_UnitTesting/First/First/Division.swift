//
//  Division.swift
//  First
//
//  Created by Jonathan Paul on 11/29/23.
//

import Foundation

class Division {
    func divisionRemainder(of number: Int, dividedBy: Int) -> (quotient: Int, remainder: Int) {
        let quotient = number / dividedBy
        let remainder = number % dividedBy
        return (quotient, remainder)
    }
}
