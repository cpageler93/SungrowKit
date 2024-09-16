//
//  SungrowWriteRequest.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//
// Sources:
// - https://github.com/bohdan-s/SunGather/files/8918236/TI_20211231_Communication.Protocol.of.Residential.Hybrid.Inverter_V1.0.23_EN.pdf
// - https://github.com/shcshc76/sungrow/blob/main/Hybrid_SHXXRT_Holding-Register.tsv

public protocol SungrowWriteRequest: SungrowRequest {
    var address: Int { get }
    func convert() -> [UInt16]?
}

public extension SungrowWriteRequest where Self == SungrowWriteRequestBool {
    static func forcedCharging(isEnabled: Bool) -> Self { .init(address: 33207, isEnabled: isEnabled) }
}

public extension SungrowWriteRequest where Self == SungrowWriteRequestForcedCharging {
    static func forcedCharging1(_ forcedCharging: SungrowForcedCharging) -> Self { .init(address: 33209, forcedCharging: forcedCharging) }
    static func forcedCharging2(_ forcedCharging: SungrowForcedCharging) -> Self { .init(address: 33214, forcedCharging: forcedCharging) }
}
