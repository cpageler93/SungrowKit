//
//  SungrowReadRequest+InputRegister.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//
// Sources:
// - https://github.com/bohdan-s/SunGather/files/8918236/TI_20211231_Communication.Protocol.of.Residential.Hybrid.Inverter_V1.0.23_EN.pdf
// - https://github.com/shcshc76/sungrow/blob/main/Hybrid_SHXXRT_Input-Register.tsv

public extension SungrowReadRequest where Self == SungrowReadRequestDeviceType {
    /// Geräte Typ
    static var deviceType: Self { .init(register: .input, address: 4999, length: 1) }
}

public extension SungrowReadRequest where Self == SungrowReadRequestUnit {
    /// Installierte Leistung
    static var nominalOutputPower:              Self { .init(register: .input, address: 5000,   length: 1, factor: 0.1, unit: .kiloWatt) }
    /// Eigene Energienutzung heute (PV & Akku)
    static var dailyOutputEnergy:               Self { .init(register: .input, address: 5002,   length: 1, factor: 0.1, unit: .kiloWattHour) }
    /// Eigene Energienutzung gesamt (PV & Akku)
    static var totalOutputEnergy:               Self { .init(register: .input, address: 5003,   length: 2, factor: 0.1, unit: .kiloWattHour) }
    /// Temperatur im Wechselrichter
    static var insideTemperature:               Self { .init(register: .input, address: 5007,   length: 1, factor: 0.1, unit: .celsius) }
    /// PV-Leistung aktuell
    static var totalDCPower:                    Self { .init(register: .input, address: 5016,   length: 2, factor: 1,   unit: .watt) }
    /// PV-Stromerzeugung heute
    static var dailyPvGeneration:               Self { .init(register: .input, address: 13001,  length: 1, factor: 0.1, unit: .kiloWattHour) }
    /// Aktuelle Wirkleistung
    static var loadPower:                       Self { .init(register: .input, address: 13007,  length: 2, factor: 1,   unit: .watt) }
    /// Aktuelle Leistung am Übergabepunkt des Versorgungsnetzes
    static var exportPower:                     Self { .init(register: .input, address: 13009,  length: 2, factor: 1,   unit: .watt, behavior: .subtract) }
    /// Direkter Eigenverbrauch aus PV heute
    static var dailyDirectEnergyConsumption:    Self { .init(register: .input, address: 13016,  length: 1, factor: 0.1, unit: .kiloWattHour) }
    /// Batterieladeleistung
    static var batteryPower:                    Self { .init(register: .input, address: 13021,  length: 1, factor: 1,   unit: .watt) }
    /// Batteriekapazität
    static var batteryLevel:                    Self { .init(register: .input, address: 13022,  length: 1, factor: 0.1, unit: .percentage) }
    /// Gesundheit der Batterie
    static var batteryHealth:                   Self { .init(register: .input, address: 13023,  length: 1, factor: 0.1, unit: .percentage) }
    /// Batterietemperatur
    static var batteryTemperature:              Self { .init(register: .input, address: 13024,  length: 1, factor: 0.1, unit: .celsius) }
    /// Batterieentladung heute
    static var dailyBatteryDischargeEnergy:     Self { .init(register: .input, address: 13025,  length: 1, factor: 0.1, unit: .kiloWattHour) }
    /// Eigenverbrauch aktuell
    static var totalActivePower:                Self { .init(register: .input, address: 13033,  length: 2, factor: 1,   unit: .watt) }
    /// Gekaufte Energie heute
    static var dailyImportEnergy:               Self { .init(register: .input, address: 13035,  length: 1, factor: 0.1, unit: .kiloWattHour) }
    /// Gekaufte Energie gesamt
    static var dailyExportEnergy:               Self { .init(register: .input, address: 13044,  length: 1, factor: 0.1, unit: .kiloWattHour) }
}

public extension SungrowReadRequest where Self == SungrowReadRequestRunningState {
    /// Betriebsstatus
    static var runningState: Self { .init(register: .input, address: 13000, length: 1) }
}
