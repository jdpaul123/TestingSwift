//
//  User.swift
//  First
//
//  Created by Jonathan Paul on 11/30/23.
//

import Foundation

struct User {
    static let upgradedNotification = Notification.Name("UserUpgraded")

    // On linkedIn a user can upgrade to a paid acount.
    // To perform the upgrade a notification is sent out using upgrade().
    func upgrade() {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            let center = NotificationCenter.default
            center.post(name: User.upgradedNotification, object: nil, userInfo: ["level": "gold"])
        }
    }
}
