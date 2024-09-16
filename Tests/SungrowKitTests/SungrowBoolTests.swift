//
//  SungrowBoolTests.swift
//  SungrowKitTests
//
//  Created by Christoph Pageler on 15.09.24.
//

import XCTest
@testable import SungrowKit

final class SungrowBoolTests: XCTestCase {
    func testDecimal() {
        for i in 0...1000 {
            switch i {
            case 170:
                XCTAssertEqual(SungrowBool(decimal: i), .true)
            case 85:
                XCTAssertEqual(SungrowBool(decimal: i), .false)
            default:
                XCTAssertNil(SungrowBool(decimal: i))
            }
        }

        XCTAssertEqual(SungrowBool(bool: true)?.decimalValue, 170)
        XCTAssertEqual(SungrowBool(bool: false)?.decimalValue, 85)
    }

    func testHex() {
        XCTAssertEqual(SungrowBool(hex: "AA"), .true)
        XCTAssertEqual(SungrowBool(hex: "aa"), .true)
        XCTAssertEqual(SungrowBool(hex: "55"), .false)
        XCTAssertNil(SungrowBool(hex: "FF"))
        XCTAssertNil(SungrowBool(hex: "00"))

        XCTAssertEqual(SungrowBool(bool: true)?.hexValue, "AA")
        XCTAssertEqual(SungrowBool(bool: false)?.hexValue, "55")
    }
}
