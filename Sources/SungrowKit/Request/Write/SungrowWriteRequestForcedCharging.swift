//
//  SungrowWriteRequestForcedCharging.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowWriteRequestForcedCharging: SungrowWriteRequest {
    public var address: Int
    public var forcedCharging: SungrowForcedCharging

    public func convert() -> [UInt16]? {
        let intArray = [
            forcedCharging.from.hour,
            forcedCharging.from.minute,
            forcedCharging.to.hour,
            forcedCharging.to.minute,
            Int(forcedCharging.targetSoc * 100)
        ]

        let resultArray = intArray.compactMap { UInt16($0) }
        
        if resultArray.count == intArray.count {
            return resultArray
        } else {
            return nil
        }
    }
}
