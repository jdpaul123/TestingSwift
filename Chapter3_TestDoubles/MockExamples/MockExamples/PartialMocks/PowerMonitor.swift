//
//  PowerMonitor.swift
//  MockExamples
//
//  Created by Jonathan Paul on 12/2/23.
//

import UIKit

struct PowerMonitor {
    var device: UIDevice // UIDevice.current should be the default value here
    // , but accessing UIDevice.current in getStatus() directly would create a hidden dependency

    func getStatus() -> String {
        if device.batteryState == .unplugged {
            return "Power is down"
        } else if device.batteryState == .unknown {
            return "Error"
        } else {
            return "Power is up"
        }
    }
}

// For doing a full mock:
protocol DeviceProtocol {
    var batteryState: UIDevice.BatteryState { get }
}

extension UIDevice: DeviceProtocol {}

struct PowerMonitorForFullMock {
    var device: DeviceProtocol

    func getStatus() -> String {
        if device.batteryState == .unplugged {
            return "Power is down"
        } else if device.batteryState == .unknown {
            return "Error"
        } else {
            return "Power is up"
        }
    }
}
