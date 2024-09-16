//
//  SungrowUnitResponse.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

import Foundation

public struct SungrowUnitResponse {
    public var value: Double
    public var unit: SungrowUnit

    public var formattedValue: String {
        let numberFormatter = NumberFormatter()
        switch unit {
        case .kiloWatt, .kiloWattHour, .celsius, .volt, .ampere, .watt, .herz, .kilogram:
            let unitShort = unit.short
            let suffix = " \(unitShort)"
            numberFormatter.positiveSuffix = suffix
            numberFormatter.negativeSuffix = suffix
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 1
        case .percentage:
            numberFormatter.numberStyle = .percent
            return numberFormatter.string(from: NSNumber(value: value / 100.0)) ?? "\(value)"
        }

        return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
