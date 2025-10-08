//
//  SeededRandomNumberGenerator.swift
//  swiftarcstdlib
//
//  Created by Piotr Suwara on 8/10/2025.
//

import Foundation

public class SeededRandomNumberGenerator: RandomNumberGenerator {
    public init(seed: Int) {
        srand48(seed)
    }
    
    public func next() -> UInt64 {
        UInt64(drand48() * Double(UInt64.max))
    }
}
