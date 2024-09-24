//
//  SungrowKitTests.swift
//  SungrowKitTests
//
//  Created by Christoph Pageler on 15.09.24.
//

import XCTest
@testable import SungrowKit

final class SungrowKitTests: XCTestCase {
    func testExample() async throws {
        let client = SungrowClient(address: "192.168.178.73")
        try client.connect()

        let isForcedChargingEnabled = try await client.read(request: .forcedCharging)
        let forcedCharging1 = try await client.read(request: .forcedCharging1)
        let forcedCharging2 = try await client.read(request: .forcedCharging2)
        if isForcedChargingEnabled {
            print("ForcedCharging: enabled")
            print("1: \(forcedCharging1)")
            print("2: \(forcedCharging2)")
        } else {
            print("ForcedCharging: disabled")
        }

//        try await client.write(request: .forcedCharging1(.init(from: .init(hour: 14, minute: 00), to: .init(hour: 16, minute: 00), targetSoc: 0.95)))
//        try await client.write(request: .forcedCharging(isEnabled: true))

//        let powerFlow = try await client.readPowerFlow()
//        print(powerFlow.output)
    }
}
