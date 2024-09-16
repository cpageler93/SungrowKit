//
//  SungrowReadRequestUnit.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowReadRequestUnit: SungrowReadRequest {
    public typealias Response = SungrowUnitResponse

    public var register: SungrowReadRegister
    public var address: Int
    public var length: Int
    
    public var factor: Double
    public var unit: SungrowUnit
    public var behavior: Behavior = .add

    public enum Behavior {
        case add
        case subtract
    }

    public func convert(rawResponse: [UInt16]) -> SungrowUnitResponse? {
        let sum: Int
        var ints = rawResponse.map { Int($0) }

        switch behavior {
        case .add:
            sum = ints.reduce(0, +)
        case .subtract:
            let first = ints.removeFirst()
            sum = ints.reduce(first, -)
        }

        return .init(
            value: Double(sum) * factor,
            unit: unit
        )
    }
}
