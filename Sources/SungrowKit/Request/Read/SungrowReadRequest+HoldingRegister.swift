//
//  SungrowReadRequest+HoldingRegister.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//
// Sources:
// - https://github.com/bohdan-s/SunGather/files/8918236/TI_20211231_Communication.Protocol.of.Residential.Hybrid.Inverter_V1.0.23_EN.pdf
// - https://github.com/shcshc76/sungrow/blob/main/Hybrid_SHXXRT_Holding-Register.tsv

public extension SungrowReadRequest where Self == SungrowReadRequestSystemClock {
    static var systemClock: Self { .init(register: .holding, address: 4999, length: 6) }
}

public extension SungrowReadRequest where Self == SungrowReadRequestBool {
    static var forcedCharging: Self { .init(register: .holding, address: 33207, length: 1) }
}

public extension SungrowReadRequest where Self == SungrowReadRequestForcedChargingValidTime {
    static var forcedChargingValidTime: Self { .init(register: .holding, address: 33208, length: 1) }
}

public extension SungrowReadRequest where Self == SungrowReadRequestForcedCharging {
    static var forcedCharging1: Self { .init(register: .holding, address: 33209, length: 5) }
    static var forcedCharging2: Self { .init(register: .holding, address: 33214, length: 5) }
}
