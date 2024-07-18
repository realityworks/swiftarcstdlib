//
//  BCDTest.swift
//  
//
//  Created by Piotr Suwara on 18/7/2024.
//

import XCTest
@testable import swiftarcstdlib

final class BCDTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testZero() throws {
        let value: UInt8 = 0
        let result = value.bcd
        XCTAssertEqual(result, 0x00)
    }

    func testVariousUInt8Values() throws {
        var value: UInt8 = 10
        var result = value.bcd
        XCTAssertEqual(result, 0x10)

        value = 1
        result = value.bcd
        XCTAssertEqual(result, 0x01)

        value = 28
        result = value.bcd
        XCTAssertEqual(result, 0x28)
    }

    func testVariousUInt16Values() throws {
        var value: UInt16 = 10
        var result = value.bcd
        XCTAssertEqual(result, 0x10)

        value = 1
        result = value.bcd
        XCTAssertEqual(result, 0x01)

        value = 2080
        result = value.bcd
        XCTAssertEqual(result, 0x2080)

    }
}
