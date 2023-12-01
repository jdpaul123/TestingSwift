//
//  User.swift
//  TestDoubleExample
//
//  Created by Jonathan Paul on 12/1/23.
//

import Foundation


protocol UserProtocol {
    var funds: Decimal { get set }
    var age: Int { get set }
    var apps: [AppProtocol] { get set }

    mutating func buy(_ app: AppProtocol) -> Bool
}

struct User: UserProtocol {
    var funds: Decimal
    var age: Int
    var apps: [AppProtocol]

    mutating func buy(_ app: AppProtocol) -> Bool {
        let possible = app.canBePurchased(by: self)
        
        if possible {
            apps.append(app)
            funds -= app.price
            return true
        } else {
            return false
        }
    }
}
