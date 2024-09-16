//
//  SungrowDeviceType.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 15.09.24.
//

public struct SungrowDeviceType {
    public var hexCode: String
    public var displayName: String?

    init(hexCode: String) {
        self.hexCode = hexCode
        self.displayName = Self.displayNames[hexCode]
    }
}

public extension SungrowDeviceType {
    static var displayNames: [String: String] = [
        "D06": "SH3K6",
        "D07": "SH4K6",
        "D09": "SH5K-20",
        "D03": "SH5K-V13",
        "D0A": "SH3K6-30",
        "D0B": "SH4K6-30",
        "D0C": "SH5K-30",
        "D17": "SH3.RS",
        "D0D": "SH3.6RS",
        "D18": "SH4.0RS",
        "D0F": "SH5.0RS",
        "D10": "SH6.0RS",
        "D1A": "SH8.0RS",
        "D1B": "SH10RS",
        "E00": "SH5.0RT",
        "E01": "SH6.0RT",
        "E02": "SH8.0RT",
        "E03": "SH10RT",
        "E10": "SH5.0RT-20",
        "E11": "SH6.0RT-20",
        "E12": "SH8.0RT-20",
        "E13": "SH10RT-20",
        "E0C": "SH5.0RT-V112",
        "E0D": "SH6.0RT-V112",
        "E0E": "SH8.0RT-V112",
        "E0F": "SH10RT-V112",
        "E08": "SH5.0RT-V122",
        "E09": "SH6.0RT-V122",
        "E0A": "SH8.0RT-V122",
        "E0B": "SH10RT-V122",
        "E20": "SH5T-V11",
        "E21": "SH6T-V11",
        "E22": "SH8T-V11",
        "E23": "SH10T-V11",
        "E24": "SH12T-V11",
        "E25": "SH15T-V11"
    ]
}
