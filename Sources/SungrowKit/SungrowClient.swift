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

    public func send<T>(message: SungrowMessage<T>) async throws -> T? {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                do {
                    let registers = try self.modbus.readInputRegisters(
                        addr: Int32(message.address),
                        count: Int32(message.length)
                    )
                    let result = message.convertToResult(registers: registers)
                    continuation.resume(returning: result)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    deinit {
        modbus.disconnect()
    }
}
