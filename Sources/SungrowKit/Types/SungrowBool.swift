//
//  SungrowBool.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

// True
// Hex: AA
// Decimal: 170
//
// False
// Hex: 55
// Decimal: 85
public enum SungrowBool: CaseIterable {
    case `true`
    case `false`

    init?(decimal: Int) {
        let hex = String(decimal, radix: 16)
        self.init(hex: hex)
    }

    init?(hex: String) {
        let upperHex = hex.uppercased()
        guard let value = Self.allCases.first(where: { $0.hexValue == upperHex }) else { return nil }
        self = value
    }

    init?(bool: Bool) {
        if bool {
            self = .true
        } else {
            self = .false
        }
    }

    public var boolValue: Bool {
        switch self {
        case .true:  return true
        case .false: return false
        }
    }

    public var hexValue: String {
        switch self {
        case .true:  return "AA"
        case .false: return "55"
        }
    }

    public var decimalValue: Int? { UInt8(hexValue, radix: 16).flatMap { Int($0) } }
}
