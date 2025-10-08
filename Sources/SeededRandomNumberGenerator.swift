//
//  SeededRandomNumberGenerator.swift
//  swiftarcstdlib
//
//  Created by Piotr Suwara on 8/10/2025.
//

import Foundation

class SeededRandomNumberGenerator: RandomNumberGenerator {
    init(seed: Int) {
        srand48(seed)
    }
    
    func next() -> UInt64 {
        UInt64(drand48() * Double(UInt64.max))
    }
}
