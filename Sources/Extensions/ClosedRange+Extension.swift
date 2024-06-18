//
//  ClosedRange+Extension.swift
//

import Foundation

public extension ClosedRange where Bound == Double {
    init<FixedWidthType>(_ uintRange: ClosedRange<FixedWidthType>) where FixedWidthType: FixedWidthInteger & Comparable {
        self = Double(uintRange.lowerBound)...Double(uintRange.upperBound)
    }
}
