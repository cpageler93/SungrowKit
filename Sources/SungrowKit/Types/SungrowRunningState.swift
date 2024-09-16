//
//  SungrowRunningState.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 09.04.24.
//

import Foundation

public struct SungrowRunningState {
    private var binaryValues: [String]

    public init?(rawValue: Int) {
        let binaryValue = String(rawValue, radix: 2)
        var values =  Array(binaryValue).map { "\($0)" }
        while values.count < 8 {
            values.insert("0", at: 0)
        }
        binaryValues = values.reversed()
    }

    public var isPowerGeneratedFromPV:      Bool { value(at: 0) }
    public var isBatteryCharging:           Bool { value(at: 1) }
    public var isBatteryDischarging:        Bool { value(at: 2) }
    public var isLoadActive:                Bool { value(at: 3) }
    public var isPowerFeedInTheGrid:        Bool { value(at: 4) }
    public var isImportingPowerFromGrid:    Bool { value(at: 5) }
    public var isPowerGeneratedFromLoad:    Bool { value(at: 7) }

    private func value(at position: Int) -> Bool {
        binaryValues[position] == "1"
    }
}


extension SungrowRunningState: CustomDebugStringConvertible {
    public var debugDescription: String {
        """

        isPowerGeneratedFromPV      : \(isPowerGeneratedFromPV)
        isBatteryCharging           : \(isBatteryCharging)
        isBatteryDischarging        : \(isBatteryDischarging)
        isLoadActive                : \(isLoadActive)
        isPowerFeedInTheGrid        : \(isPowerFeedInTheGrid)
        isImportingPowerFromGrid    : \(isImportingPowerFromGrid)
        isPowerGeneratedFromLoad    : \(isPowerGeneratedFromLoad)
        """
    }
}
