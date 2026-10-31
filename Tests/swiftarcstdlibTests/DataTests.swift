//
//  DataTests.swift
//  swiftarcstdlib
//
//  Created by Piotr Suwara on 31/10/2026.
//

import XCTest
@testable import swiftarcstdlib

final class DataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChunkCountZero() throws {
        let chunkSize = 11
        let data = Data(count: 0)
        
        XCTAssertEqual(data.chunkCount(ofSize: chunkSize), 0)
    }
    
    func testChunkCountOne() throws {
        let chunkSize = 1
        let data = Data(count: 1)
        
        XCTAssertEqual(data.chunkCount(ofSize: chunkSize), 1)
    }
    
    func testChunkCountRemainder() throws {
        let chunkSizeA = 2
        let dataA = Data(count: 3)
        
        XCTAssertEqual(dataA.chunkCount(ofSize: chunkSizeA), 2)
        
        let chunkSizeB = 3
        let dataB = Data(count: 5)
        
        XCTAssertEqual(dataB.chunkCount(ofSize: chunkSizeB), 2)
        
        let chunkSizeC = 4
        let dataC = Data(count: 20)
        
        XCTAssertEqual(dataC.chunkCount(ofSize: chunkSizeC), 5)
    }
    
    func testChunkCountLarge() throws {
        let chunkSizeA = 32
        let dataA = Data(count: 64)
        
        XCTAssertEqual(dataA.chunkCount(ofSize: chunkSizeA), 2)
        
        let chunkSizeB = 400
        let dataB = Data(count: 850)
        
        XCTAssertEqual(dataB.chunkCount(ofSize: chunkSizeB), 3)
    }
    
    func testChunkSize() throws {
        let chunkSizeA = 32
        let dataA = Data(count: 64)
        let chunkA = dataA.chunk(atIndex: 0, ofChunksize: chunkSizeA)
        XCTAssertEqual(chunkA?.count, chunkSizeA)
        
        let chunkSizeB = 400
        let dataB = Data(count: 850)
        let chunkB = dataB.chunk(atIndex: 2, ofChunksize: chunkSizeB)
        
        XCTAssertEqual(chunkB?.count, 50)
        
        let chunkSizeC = 8
        let dataC = Data(count: 15)
        let chunkC = dataC.chunk(atIndex: 1, ofChunksize: chunkSizeC)
        
        XCTAssertEqual(chunkC?.count, 7)
    }
    
    func testChunkSizeInvalid() throws {
        let chunkSizeA = 32
        let dataA = Data(count: 64)
        let chunkA = dataA.chunk(atIndex: 4, ofChunksize: chunkSizeA)
        XCTAssertNil(chunkA)
        
        let chunkSizeB = 400
        let dataB = Data(count: 850)
        let chunkB = dataB.chunk(atIndex: 3, ofChunksize: chunkSizeB)
        
        XCTAssertNil(chunkB)
        
        let chunkSizeC = 8
        let dataC = Data(count: 15)
        let chunkC = dataC.chunk(atIndex: 6, ofChunksize: chunkSizeC)
        
        XCTAssertNil(chunkC)
    }
}
