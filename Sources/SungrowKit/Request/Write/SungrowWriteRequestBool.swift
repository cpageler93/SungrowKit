//
//  SungrowWriteRequestBool.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowWriteRequestBool: SungrowWriteRequest {
    public var address: Int
    public var isEnabled: Bool

    public func convert() -> [UInt16]? {
        guard let decimal = SungrowBool(bool: isEnabled)?.decimalValue else { return nil }
        return [UInt16(decimal)]
    }
}
