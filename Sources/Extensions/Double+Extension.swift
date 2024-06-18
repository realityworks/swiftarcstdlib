//
//  Double+Extension.swift
//

import Foundation

public extension Double {
    mutating func roundToNearest(value: Double) {
        let factor = Double(1 / value)
        let result = self * factor
        self = result.rounded() / factor
    }

    func roundedToNearest(value: Double) -> Double {
        let factor = Double(1 / (value))
        let result = self * factor
        return result.rounded() / factor
    }

    func rounded(toDecimal decimal: Int) -> Double {
        let multiplier = pow(10.0, Double(decimal))
        let value = Double(self * multiplier).rounded()
        return value / multiplier
    }
}
