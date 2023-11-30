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
    // Using dependency injection to allow our tests to use it's own instance of NofiticationCenter to ensure that the notification is triggered by the upgrade() method
    func upgrade(using center: NotificationCenter = NotificationCenter.default) {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            center.post(name: User.upgradedNotification, object: nil, userInfo: ["level": "gold"])
        }
    }
}
