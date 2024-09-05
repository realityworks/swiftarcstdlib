//
//  WrappedSetTests.swift
//  
//
//  Created by Piotr Suwara on 3/9/2024.
//

import XCTest

final class WrappedSetTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testNonWrappedValueInSet() throws {
        let setOf = Set<Int>.closedWrapped(start: 5, end: 10, maximum: 100)
        XCTAssertEqual(setOf.contains(5), true)
        XCTAssertEqual(setOf.contains(10), true)
        XCTAssertEqual(setOf.contains(11), false)
    }

    func testWrappedValueInSet() throws {
        let setOf = Set<Int>.closedWrapped(start: 50, end: 10, maximum: 80)
        XCTAssertEqual(setOf.contains(20), false)
        XCTAssertEqual(setOf.contains(70), true)
        XCTAssertEqual(setOf.contains(5), true)
        XCTAssertEqual(setOf.contains(80), true)
        XCTAssertEqual(setOf.contains(10), true)
        XCTAssertEqual(setOf.contains(11), false)
        XCTAssertEqual(setOf.contains(50), true)
    }

    func testOpenWrappedValueInSet() throws {
        let setOf = Set<Int>.openWrapped(start: 50, end: 10, maximum: 80)
        XCTAssertEqual(setOf.contains(10), false)
        XCTAssertEqual(setOf.contains(50), false)
    }

    func testEqualOpenWrappedValueInSet() throws {
        let setOf = Set<Int>.openWrapped(start: 50, end: 50, maximum: 80)
        XCTAssertEqual(setOf.contains(50), false)
        XCTAssertEqual(setOf.contains(51), true)
        XCTAssertEqual(setOf.contains(49), true)
    }

    func testEmptyOpenWrappedValueInSet() throws {
        let setOf = Set<Int>.openWrapped(start: 50, end: 51, maximum: 80)
        XCTAssertEqual(setOf.contains(50), false)
        XCTAssertEqual(setOf.contains(51), false)
        XCTAssertEqual(setOf.contains(49), false)
        XCTAssertEqual(setOf.contains(52), false)
    }
}
