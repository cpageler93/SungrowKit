//
//  SungrowClient.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 05.04.24.
//

import Foundation
import SwiftyModbus

public class SungrowClient {
    public let address: String
    public let port: Int
    public let timeout: TimeInterval

    private let modbus: SwiftyModbus

    public init(
        address: String,
        port: Int = 502,
        timeout: TimeInterval = 2.0
    ) {
        self.address = address
        self.port = port
        self.timeout = timeout

        modbus = .init(address: address, port: port)
        modbus.responseTimeout = timeout
        modbus.setSlave(1)
    }

    public func connect() throws {
        try modbus.connect()
    }

    public func send(request: SungrowRequest) async throws -> SungrowResponse {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                // Try to read input registers
                let registers: [UInt16]
                do {
                    registers = try self.modbus.readInputRegisters(
                        addr: Int32(request.address),
                        count: Int32(request.length)
                    )
                } catch {
                    continuation.resume(throwing: SungrowError.failedToReadRegisters)
                    return
                }

                // Convert registers to value
                guard let value = self.registersToValue(request: request, registers: registers) else {
                    continuation.resume(throwing: SungrowError.noValue)
                    return
                }

                // Build response
                let response = SungrowResponse(
                    name: request.displayName,
                    value: value,
                    unit: request.unit
                )
                continuation.resume(returning: response)
            }
        }
    }

    private func registersToValue(request: SungrowRequest, registers: [UInt16]) -> Double? {
        switch request.length {
        case 1:
            guard let value = registers[safe: 0] else { return nil }
            return Double(value) * request.factor
        case 2:
            guard let value1 = registers[safe: 0] else { return nil }
            guard let value2 = registers[safe: 1] else { return nil }

            let value1WithFactor = Double(value1) * request.factor
            let value2WithFactor = Double(value2) * request.factor

            switch request.behaviour {
            case .add:
                return value1WithFactor + value2WithFactor
            case .subtract:
                return value1WithFactor - value2WithFactor
            }
        default:
            return nil
        }
    }

    deinit {
        modbus.disconnect()
    }
}
