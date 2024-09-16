//
//  SungrowReadRequest.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public enum SungrowReadRegister {
    case input
    case holding
}

public protocol SungrowReadRequest<Response>: SungrowRequest {
    associatedtype Response

    var register: SungrowReadRegister { get }
    var address: Int { get }
    var length: Int { get }

    func convert(rawResponse: [UInt16]) -> Response?
}
