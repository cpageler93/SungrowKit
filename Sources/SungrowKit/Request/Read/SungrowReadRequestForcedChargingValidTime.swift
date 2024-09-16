//
//  SungrowReadRequestForcedChargingValidTime.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowReadRequestForcedChargingValidTime: SungrowReadRequest {
    public typealias Response = SungrowForcedChargingValidTime
    public var register: SungrowReadRegister
    public var address: Int
    public var length: Int

    public func convert(rawResponse: [UInt16]) -> SungrowForcedChargingValidTime? {
        guard let value = rawResponse.first else { return nil }
        return .init(rawValue: Int(value))
    }
}
