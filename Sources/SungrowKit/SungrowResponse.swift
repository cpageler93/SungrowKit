//
//  SungrowResponse.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 06.04.24.
//

import Foundation

public struct SungrowResponse {
    public let name: String
    public let value: Double
    public let unit: SungrowUnit?

    public var formattedValue: String {
        let numberFormatter = NumberFormatter()
        switch unit {
        case .kiloWatt, .kiloWattHour, .celsius, .volt, .ampere, .watt, .herz, .kilogram:
            let unitShort = unit?.short ?? ""
            let suffix = " \(unitShort)"
            numberFormatter.positiveSuffix = suffix
            numberFormatter.negativeSuffix = suffix
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 1
        case .percentage:
            numberFormatter.numberStyle = .percent
            return numberFormatter.string(from: NSNumber(value: value / 100.0)) ?? "\(value)"
        case .binary:
            return String(Int(value), radix: 2)
        case nil:
            break
        }

        return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
