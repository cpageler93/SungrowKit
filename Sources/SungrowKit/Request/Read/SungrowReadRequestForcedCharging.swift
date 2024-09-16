//
//  SungrowReadRequestForcedCharging.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowReadRequestForcedCharging: SungrowReadRequest {
    public typealias Response = SungrowForcedCharging
    public var register: SungrowReadRegister
    public var address: Int
    public var length: Int

    public func convert(rawResponse: [UInt16]) -> SungrowForcedCharging? {
        guard let value1 = rawResponse[safe: 0] else { return nil }
        guard let value2 = rawResponse[safe: 1] else { return nil }
        guard let value3 = rawResponse[safe: 2] else { return nil }
        guard let value4 = rawResponse[safe: 3] else { return nil }
        guard let value5 = rawResponse[safe: 4] else { return nil }

        return .init(
            from: .init(
                hour: Int(value1),
                minute: Int(value2),
                second: 0
            ),
            to: .init(
                hour: Int(value3),
                minute: Int(value4),
                second: 0
            ),
            targetSoc: Double(value5) / 100
        )
    }
}
