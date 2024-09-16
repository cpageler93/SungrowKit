//
//  SungrowReadRequestBool.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowReadRequestBool: SungrowReadRequest {
    public typealias Response = Bool
    public var register: SungrowReadRegister
    public var address: Int
    public var length: Int

    public func convert(rawResponse: [UInt16]) -> Bool? {
        rawResponse.first
            .flatMap { SungrowBool(decimal: Int($0)) }
            .map { $0.boolValue }
    }
}
