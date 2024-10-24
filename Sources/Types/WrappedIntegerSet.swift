//
//  WrappedIntegerSet.swift
//
//
//  Created by Piotr Suwara on 3/9/2024.
//

import Foundation

public enum OpenClosedSet {
    case open
    case closed
}

protocol WrappedIntegerSet {
    associatedtype Element: BinaryInteger
    var start: Element { get set }
    var end: Element { get set }
    var maximum: Element { get set }
    var setOfValid: Set<Element> { get set }
    var openClosed: OpenClosedSet { get set }
}

extension WrappedIntegerSet {
    public func isInWrappedRange(_ element: Element) -> Bool {
        setOfValid.contains(element)
    }
}

public struct OpenWrappedIntegerSet<Element: BinaryInteger>: WrappedIntegerSet {
    var start: Element
    var end: Element
    var maximum: Element
    var setOfValid: Set<Element>
    var openClosed: OpenClosedSet

    public init(
        start: Element,
        end: Element,
        maximum: Element
    ) {
        self.start = start
        self.end = end
        self.maximum = maximum
        self.openClosed = .open
        self.setOfValid = .openWrapped(
            start: start,
            end: end,
            maximum: maximum
        )
    }
}

public struct ClosedWrappedIntegerSet<Element: BinaryInteger>: WrappedIntegerSet {
    var start: Element
    var end: Element
    var maximum: Element
    var setOfValid: Set<Element>
    var openClosed: OpenClosedSet

    public init(
        start: Element,
        end: Element,
        maximum: Element
    ) {
        self.start = start
        self.end = end
        self.maximum = maximum
        self.openClosed = .closed
        self.setOfValid = .closedWrapped(
            start: start,
            end: end,
            maximum: maximum
        )
    }
}
