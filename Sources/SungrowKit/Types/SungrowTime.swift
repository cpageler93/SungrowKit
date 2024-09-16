//
//  SungrowTime.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowTime {
    public var hour: Int
    public var minute: Int
    public var second: Int

    public init(hour: Int, minute: Int, second: Int = 0) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}
