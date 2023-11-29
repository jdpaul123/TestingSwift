//
//  Hater.swift
//  First
//
//  Created by Jonathan Paul on 11/28/23.
//

import Foundation


struct Hater {
    var hating = false

    mutating func hadABadDay() {
        hating = true
    }

    mutating func hadAGoodDay() {
        hating = false
    }
}
