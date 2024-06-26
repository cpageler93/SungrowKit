//
//  SungrowRequest.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 05.04.24.
//

public struct SungrowRequest {
    public enum Behavior {
        case add
        case subtract
    }

    public let address: Int
    public let length: Int
    public let factor: Double
    public let unit: SungrowUnit?
    public var behaviour = Behavior.add
}

/// Source: https://github.com/bohdan-s/SunGather/files/8918236/TI_20211231_Communication.Protocol.of.Residential.Hybrid.Inverter_V1.0.23_EN.pdf
public extension SungrowRequest {
    static var deviceTypeCode:                  SungrowRequest { .init(address: 4999,   length: 1, factor: 1,   unit: nil) }
    static var nominalOutputPower:              SungrowRequest { .init(address: 5000,   length: 1, factor: 0.1, unit: .kiloWatt) }
    static var dailyOutputEnergy:               SungrowRequest { .init(address: 5002,   length: 1, factor: 0.1, unit: .kiloWattHour) }
    static var totalOutputEnergy:               SungrowRequest { .init(address: 5003,   length: 2, factor: 0.1, unit: .kiloWattHour) }
    static var insideTemperature:               SungrowRequest { .init(address: 5007,   length: 1, factor: 0.1, unit: .celsius) }
    static var totalDCPower:                    SungrowRequest { .init(address: 5016,   length: 2, factor: 1,   unit: .watt) }
    static var runningState:                    SungrowRequest { .init(address: 13000,  length: 1, factor: 1,   unit: .binary)}
    static var dailyPvGeneration:               SungrowRequest { .init(address: 13001,  length: 1, factor: 0.1, unit: .kiloWattHour) }
    static var loadPower:                       SungrowRequest { .init(address: 13007,  length: 2, factor: 1,   unit: .watt) }
    static var exportPower:                     SungrowRequest { .init(address: 13009,  length: 2, factor: 1,   unit: .watt, behaviour: .subtract) }
    static var dailyDirectEnergyConsumption:    SungrowRequest { .init(address: 13016,  length: 1, factor: 0.1, unit: .kiloWattHour)}
    static var batteryPower:                    SungrowRequest { .init(address: 13021,  length: 1, factor: 1,   unit: .watt)}
    static var batteryLevel:                    SungrowRequest { .init(address: 13022,  length: 1, factor: 0.1, unit: .percentage)}
    static var batteryHealth:                   SungrowRequest { .init(address: 13023,  length: 1, factor: 0.1, unit: .percentage)}
    static var batteryTemperature:              SungrowRequest { .init(address: 13024,  length: 1, factor: 0.1, unit: .celsius) }
    static var dailyBatteryDischargeEnergy:     SungrowRequest { .init(address: 13025,  length: 1, factor: 0.1, unit: .kiloWattHour) }
    static var totalActivePower:                SungrowRequest { .init(address: 13033,  length: 2, factor: 1,   unit: .watt) }
    static var dailyImportEnergy:               SungrowRequest { .init(address: 13035,  length: 1, factor: 0.1, unit: .kiloWattHour) }
    static var dailyExportEnergy:               SungrowRequest { .init(address: 13044,  length: 1, factor: 0.1, unit: .kiloWattHour) }
}

public extension SungrowRequest {
    private static var names: [Int: String] {
        [
            4999:  "Device type code",
            5000:  "Nominal Output Power",
            5002:  "Daily Output Energy",
            5003:  "Total Output Energy",
            5007:  "Inside Temperature",
            5010:  "MPPT 1 Voltage",
            5011:  "MPPT 1 Current",
            5012:  "MPPT 2 Voltage",
            5013:  "MPPT 2 Current",
            5016:  "Total DC Power",
            5018:  "Spannung Ph A",
            5019:  "Spannung Ph B",
            5020:  "Spannung Ph C",
            5032:  "Reactive Power",
            5034:  "Power Factor",
            5035:  "Grid Frequency",
            6226:  "Monthly PV energy yields January",
            6227:  "Monthly PV energy yields February",
            6228:  "Monthly PV energy yields March",
            6229:  "Monthly PV energy yields April",
            6230:  "Monthly PV energy yields May",
            6231:  "Monthly PV energy yields June",
            6232:  "Monthly PV energy yields July",
            6233:  "Monthly PV energy yields August",
            6234:  "Monthly PV energy yields September",
            6235:  "Monthly PV energy yields October",
            6236:  "Monthly PV energy yields November",
            6237:  "Monthly PV energy yields December",
            6416:  "Monthly direct energy consumption from PV January",
            6417:  "Monthly direct energy consumption from PV February",
            6418:  "Monthly direct energy consumption from PV March",
            6419:  "Monthly direct energy consumption from PV April",
            6420:  "Monthly direct energy consumption from PV May",
            6421:  "Monthly direct energy consumption from PV June",
            6422:  "Monthly direct energy consumption from PV July",
            6423:  "Monthly direct energy consumption from PV August",
            6424:  "Monthly direct energy consumption from PV Septemper",
            6425:  "Monthly direct energy consumption from PV October",
            6426:  "Monthly direct energy consumption from PV November",
            6427:  "Monthly direct energy consumption from PV december",
            6595:  "Monthly export energy from PV January",
            6596:  "Monthly export energy from PV February",
            6597:  "Monthly export energy from PV March",
            6598:  "Monthly export energy from PV April",
            6599:  "Monthly export energy from PV May",
            6600:  "Monthly export energy from PV June",
            6601:  "Monthly export energy from PV July",
            6602:  "Monthly export energy from PV August",
            6603:  "Monthly export energy from PV September",
            6604:  "Monthly export energy from PV October",
            6605:  "Monthly export energy from PV November",
            6606:  "Monthly export energy from PV Dezember",
            12999: "System State",
            13000: "Running State",
            13001: "Daily PV Generation",
            13002: "Total PV Generation",
            13004: "Daily export energy from PV",
            13005: "Total export energy from PV",
            13007: "Load power",
            13009: "Export power",
            13011: "Daily battery charge energy from PV",
            13012: "Total battery charge energy from PV",
            13014: "CO2-reduction",
            13016: "Daily direct Energy Consumption",
            13017: "Total direct Energy Consumption",
            13019: "Battery voltage",
            13020: "Battery current",
            13021: "Battery power",
            13022: "Battery level",
            13023: "Battery state of health",
            13024: "Battery Temperature",
            13025: "Daily battery discharge Energy",
            13026: "Total battery discharge Energy",
            13028: "Self-consumption of today",
            13029: "Grid state",
            13030: "Phase A current",
            13031: "Phase B current",
            13032: "Phase C current",
            13033: "Total active power",
            13035: "Daily Import Energy",
            13036: "Total Import Energy",
            13038: "Battery Capacity",
            13039: "Daily Charge Energy",
            13040: "Total Charge Energy",
            13044: "Daily export energy",
            13045: "Total export energy",
            13049: "Inverter alarm",
            13051: "Grid-side fault",
            13053: "System fault 1",
            13055: "System fault 2",
            13057: "DC-side fault",
            13059: "Permanent fault",
            13061: "BDC-side fault",
            13063: "BDC-side permanent fault",
            13065: "Battery fault",
            13067: "Battery alarm",
            13069: "BMS alarm",
            13071: "BMS protection",
            13073: "BMS fault 1",
            13075: "BMS fault 2",
            13077: "BMS alarm 2"
        ]
    }

    var displayName: String { Self.names[address] ?? "\(address)" }
}
