//
//  User.swift
//  TDD
//
//  Created by Jonathan Paul on 12/27/23.
//

import Foundation

struct User {
    // In the refactor step I changed this from an array to a set
    var products = Set<String>()

    mutating func buy(_ product: String) {
        products.insert(product)
    }

    func owns(_ product: String) -> Bool {
        return products.contains(product)
    }
}
