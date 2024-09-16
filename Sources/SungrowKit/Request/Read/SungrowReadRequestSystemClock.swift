//
//  SungrowReadRequestSystemClock.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowReadRequestSystemClock: SungrowReadRequest {
    public typealias Response = SungrowDateTime
    public var register: SungrowReadRegister
    public var address: Int
    public var length: Int

    public func convert(rawResponse: [UInt16]) -> SungrowDateTime? {
        guard let value1 = rawResponse[safe: 0] else { return nil }
        guard let value2 = rawResponse[safe: 1] else { return nil }
        guard let value3 = rawResponse[safe: 2] else { return nil }
        guard let value4 = rawResponse[safe: 3] else { return nil }
        guard let value5 = rawResponse[safe: 4] else { return nil }
        guard let value6 = rawResponse[safe: 5] else { return nil }

        return .init(
            date: .init(
                year: Int(value1),
                month: Int(value2),
                day: Int(value3)
            ),
            time: .init(
                hour: Int(value4),
                minute: Int(value5),
                second: Int(value6)
            )
        )
    }
}
