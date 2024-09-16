//
//  SungrowReadRequestDeviceType.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowReadRequestDeviceType: SungrowReadRequest {
    public typealias Response = SungrowDeviceType
    public var register: SungrowReadRegister
    public var address: Int
    public var length: Int

    public func convert(rawResponse: [UInt16]) -> SungrowDeviceType? {
        guard let hex = rawResponse.first.map({ String($0, radix: 16) })?.uppercased() else { return nil }
        return .init(hexCode: hex)
    }
}
