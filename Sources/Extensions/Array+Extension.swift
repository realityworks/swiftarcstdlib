//
//  Array+Extension.swift
//

import Foundation

public extension Array where Self.Element: Hashable {
    func uniqueInOrderCounts() -> [Int] {
        let counts = reduce(into: [(element: Element, count: Int)]()) { counts, element in
            if !counts.contains(where: { $0.element == element }) {
                counts.append((element: element, count: self.filter { $0 == element }.count))
            }
        }.map { $0.count }
        return counts
    }
}

public extension Array where Self.Element: FixedWidthInteger {
    func condensedToNibbles(preSized size: Int? = nil) -> [UInt8] {
        let size = size ?? (self.count + 1) / 2
        let deviceIndexArray: [UInt8] = self.map { UInt8($0) }
        var condensedArray: [UInt8] = Array<UInt8>(repeating: 0xFF, count: size)
        deviceIndexArray.enumerated().forEach { singleIndexElement in
            let offsetToArray = Int(singleIndexElement.offset)
            let index = singleIndexElement.element

            let offsetToCondensedArray = offsetToArray >> 1
            if offsetToArray.isMultiple(of: 2) {
                let value = ((index & 0x0F) << 4) | 0x0F
                condensedArray[offsetToCondensedArray] = value
            } else {
                var value = condensedArray[offsetToCondensedArray] & 0xF0
                value = value | (index & 0x0F)
                condensedArray[offsetToCondensedArray] = value
            }
        }

        return condensedArray
    }
}
