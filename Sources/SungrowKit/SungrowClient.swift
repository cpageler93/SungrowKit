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

    public private(set) var isConnected = false

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
        isConnected = true
    }

    public func disconnect() {
        modbus.disconnect()
        isConnected = false
    }

    public func read<R: SungrowReadRequest>(request: R) async throws -> R.Response {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                let response: R.Response
                do {
                    let rawResponse: [UInt16]
                    switch request.register {
                    case .input:
                        rawResponse = try self.modbus.readInputRegisters(
                            addr: Int32(request.address),
                            count: Int32(request.length)
                        )
                    case .holding:
                        rawResponse = try self.modbus.readRegisters(
                            addr: Int32(request.address),
                            count: Int32(request.length)
                        )
                    }

                    guard let convertedResponse = request.convert(rawResponse: rawResponse) else {
                        throw SungrowError.noValue
                    }

                    response = convertedResponse
                } catch {
                    if let modbusError = error as? SwiftyModbus.ModbusError {
                        let isBrokenPipe = modbusError.errno == 32
                        if isBrokenPipe {
                            self.isConnected = false
                        }
                    }
                    continuation.resume(throwing: SungrowError.failedToSendRequest)
                    return
                }

                continuation.resume(returning: response)
            }
        }
    }

    public func write<R: SungrowWriteRequest>(request: R) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                do {
                    guard let data = request.convert() else {
                        throw SungrowError.noValue
                    }
                    try self.modbus.writeRegisters(addr: Int32(request.address), data: data)
                } catch {
                    if let modbusError = error as? SwiftyModbus.ModbusError {
                        let isBrokenPipe = modbusError.errno == 32
                        if isBrokenPipe {
                            self.isConnected = false
                        }
                    }
                    continuation.resume(throwing: SungrowError.failedToSendRequest)
                    return
                }
                continuation.resume()
            }
        }
    }

    /// Sources:
    /// - https://noegel.io/posts/2022-10-09-sungrow/
    /// - https://gist.github.com/dnoegel/c6cb7f176d25199c0575dce97ee87253
    public func readPowerFlow() async throws -> SungrowPowerFlow {
        let load = try await read(request: .loadPower).value
        let grid = try await read(request: .exportPower).value
        let solar = try await read(request: .totalDCPower).value
        let battery = try await read(request: .batteryPower).value
        let runningState = try await read(request: .runningState)

        return .calculate(
            input: .init(
                load: load,
                grid: grid,
                solar: solar,
                battery: battery,
                runningState: runningState
            )
        )
    }

    deinit {
        modbus.disconnect()
    }
}
