//
//  Polarity.swift
//  swiftarcstdlib
//
//  Created by Piotr Suwara on 27/10/2025.
//

import Foundation

public enum Polarity: UInt8, Storable {
    case negative = 0x00
    case positive = 0x01

    public mutating func toggle() {
       self = self == .positive ? .negative : .positive
    }

    public static func random() -> Polarity {
        return Bool.random() ? .negative : .positive
    }
}
