//
//  WrappedIntegerSet.swift
//
//
//  Created by Piotr Suwara on 3/9/2024.
//

import Foundation

public struct WrappedIntegerSet<Element: BinaryInteger> {
    var start: Element
    var end: Element
    var maximum: Element
    private var setOfValid: Set<Element>

    init(
        start: Element,
        end: Element,
        maximum: Element
    ) {
        self.start = start
        self.end = end
        self.maximum = maximum
        self.setOfValid = .wrapped(start: start, end: end, maximum: maximum)
    }

    func isInWrappedRange(_ element: Element) -> Bool {
        setOfValid.contains(element)
    }
}
