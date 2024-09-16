//
//  SungrowUnit.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 05.04.24.
//

public enum SungrowUnit {
    case kiloWatt
    case kiloWattHour
    case celsius
    case volt
    case ampere
    case watt
    case herz
    case kilogram
    case percentage

    public var short: String {
        switch self {
        case .kiloWatt:     return "kW"
        case .kiloWattHour: return "kWh"
        case .celsius:      return "°C"
        case .volt:         return "V"
        case .ampere:       return "A"
        case .watt:         return "W"
        case .herz:         return "hz"
        case .kilogram:     return "kg"
        case .percentage:   return "%"
        }
    }
}
