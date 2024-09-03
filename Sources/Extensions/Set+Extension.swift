//
//  Set+Extension.swift
//

import Foundation

public extension Set {
    mutating func toggle(_ element: Element) {
        if contains(element) {
            remove(element)
        } else {
            insert(element)
        }
    }
}

// MARK: Wrapped Set
public extension Set where Element: BinaryInteger {
    static func wrapped(start: Element, end: Element, maximum: Element) -> Set<Element> {
        var setOf: Self = .init()

        var value = start
        let unwrappedEndValue = start < end ? end : (end+maximum+1) // +1 to include maximum
        let range = unwrappedEndValue - start
        var count = 0

        while (count <= range) {
            setOf.insert(value)
            value += 1
            value = value % (maximum+1)

            count += 1
        }

        return setOf
    }
}
