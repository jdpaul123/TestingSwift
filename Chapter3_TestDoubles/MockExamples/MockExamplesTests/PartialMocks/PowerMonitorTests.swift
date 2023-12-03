//
//  PowerMonitorTests.swift
//  MockExamplesTests
//
//  Created by Jonathan Paul on 12/2/23.
//

import UIKit
import XCTest
@testable import MockExamples

// NOTE: You can only do a partial mock of classes (not structs) because it requires inheritence
// NOTE: A full mock is where we wrap UIDevice in a protocol, then send in a complete replacement
// that conforms to the same protocol.

//class UnpluggedDeviceMock: UIDevice {
//    override var batteryState: BatteryState {
//        return .unplugged
//    }
//}
//
//class UnknownDeviceMock: UIDevice {
//    override var batteryState: BatteryState {
//        return .unknown
//    }
//}
//
//class ChargingDeviceMock: UIDevice {
//    override var batteryState: BatteryState {
//        return .charging
//    }
//}

// Rather than 3 individual mocks we can make 1 that takes the battery state and overrides it
class DevicePartialMock: UIDevice {
    var testBatteryState: BatteryState

    init(testBatteryState: BatteryState) {
        self.testBatteryState = testBatteryState
        super.init()
    }

    override var batteryState: BatteryState {
        return testBatteryState
    }
}

final class PowerMonitorTests: XCTestCase {
    func testUnpluggedDeviceShowsDown() {
        // given
        let sut = PowerMonitor(device: DevicePartialMock(testBatteryState: .unplugged))

        // when
        let message = sut.getStatus()

        // then
        XCTAssertEqual(message, "Power is down")
    }
}

// To create a full mock we would do this
struct DeviceFullMock: DeviceProtocol {
    var testBatteryState: UIDevice.BatteryState

    var batteryState: UIDevice.BatteryState {
        return testBatteryState
    }
}

final class PowerMonitorTestsWithFullMock: XCTestCase {
    func testUnpluggedDeviceShowsDown() {
        // given: Using PowerMonitorForFullMock instead of PowerMonitor
        let sut = PowerMonitorForFullMock(device: DeviceFullMock(testBatteryState: .unplugged))

        // when
        let message = sut.getStatus()

        // then
        XCTAssertEqual(message, "Power is down")
    }
}
