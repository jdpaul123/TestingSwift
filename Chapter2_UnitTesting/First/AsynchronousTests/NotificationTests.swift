//
//  NotificationTests.swift
//  AsynchronousTests
//
//  Created by Jonathan Paul on 11/30/23.
//

import XCTest
@testable import First

final class NotificationTests: XCTestCase {
    func testUserUpgradedPostsNotification() {
        // given
        let user = User()
        let expectation = XCTNSNotificationExpectation(name: User.upgradedNotification)

        expectation.handler = { notification -> Bool in
            guard let level = notification.userInfo?["level"] as? String else {
                return false
            }

            if level == "gold" {
                return true
            } else {
                return false
            }
        }

        // when
        user.upgrade()

        // then
        wait(for: [expectation], timeout: 3)
    }
}
