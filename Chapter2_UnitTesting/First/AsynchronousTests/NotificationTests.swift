//
//  NotificationTests.swift
//  AsynchronousTests
//
//  Created by Jonathan Paul on 11/30/23.
//

import XCTest
@testable import First

final class NotificationTests: XCTestCase {
    /*
     Tip: Sometimes you might want to add a notification center observer during a test, and
     that’s a perfectly valid solution. However, please make extra sure you remove that
     observer when you’re done, otherwise you might be introducing all sorts of problems by
     accident – use addTeardownBlock() to make sure your observers always get removed.
     Something like NotificationCenter.default.removeObserver(yourObserver) is usually enough.
     */
    func testUserUpgradedPostsNotification() {
        // given
        let user = User()
        // Create our own Notification Center and inject that into the expectation. This is using the dependency injection paradigm
        // so we can be sure that the notification is being triggered by user.upgrade()
        // and not anything else
        let center = NotificationCenter()
        let expectation = XCTNSNotificationExpectation(name: User.upgradedNotification, 
                                                       object: nil,
                                                       notificationCenter: center)


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
        user.upgrade(using: center)

        // then
        wait(for: [expectation], timeout: 3)
    }
}
