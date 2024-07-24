//
//  BCD.swift
//  
//
//  Created by Piotr Suwara on 18/7/2024.
//

import Foundation

public extension BinaryInteger {
    var bcd: Self {
        var value: Self = 0
        var numeral: Int = 0
        var digits = self
        while digits != 0 {
            let digit = digits % 10
            value = value | Self(digit) << (4 * numeral)
            numeral += 1
            digits = (digits / 10)
        }
        return value
    }
}

