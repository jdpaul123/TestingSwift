//
//  HouseAndBuyer.swift
//  MockExamples
//
//  Created by Jonathan Paul on 12/2/23.
//

import Foundation

protocol HouseProtocol {
    func conductViewing()
}

class House: HouseProtocol {
    func conductViewing() {
        print("A potential buyer viewed the house.")
    }
}

struct Buyer {
    func view(_ house: HouseProtocol) {
        house.conductViewing()
    }
}


