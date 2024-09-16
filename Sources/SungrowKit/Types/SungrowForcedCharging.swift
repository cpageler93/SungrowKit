//
//  SungrowForcedCharging.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowForcedCharging {
    public var from: SungrowTime
    public var to: SungrowTime
    public var targetSoc: Double

    public init(from: SungrowTime, to: SungrowTime, targetSoc: Double) {
        self.from = from
        self.to = to
        self.targetSoc = targetSoc
    }
}
