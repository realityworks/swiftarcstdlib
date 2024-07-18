//
//  BCD.swift
//  
//
//  Created by Piotr Suwara on 18/7/2024.
//

import Foundation

public protocol BCDConvertible {
    associatedtype ValueType: BinaryInteger
    var bcd: ValueType { get }
}

public extension BCDConvertible where Self: BinaryInteger {
    var bcd: ValueType {
        var value: ValueType = 0
        var numeral: Int = 0
        var digits = self
        while digits != 0 {
            let digit = digits % 10
            value = value | ValueType(digit) << (4 * numeral)
            numeral += 1
            digits = (digits / 10)
        }
        return value
    }
}

extension UInt8: BCDConvertible {
    public typealias ValueType = Self
}

extension UInt16: BCDConvertible {
    public typealias ValueType = Self
}


