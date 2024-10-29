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

public struct WrappedIntegerSet<Element: BinaryInteger> {
    var start: Element
    var end: Element
    var maximum: Element
    private var setOfValid: Set<Element>
    public var openClosed: OpenClosedSet

    public init(
        start: Element,
        end: Element,
        maximum: Element,
        openClosed: OpenClosedSet
    ) {
        self.start = start
        self.end = end
        self.maximum = maximum
        self.openClosed = openClosed

        if openClosed == .closed {
            self.setOfValid = .closedWrapped(start: start, end: end, maximum: maximum)
        } else {
            self.setOfValid = .openWrapped(start: start, end: end, maximum: maximum)
        }
    }

    public func isInWrappedRange(_ element: Element) -> Bool {
        setOfValid.contains(element)
    }

    public func overlaps(_ integerSet: WrappedIntegerSet<Element>) -> Bool {
        let intersection = setOfValid.intersection(integerSet.setOfValid)
        return !intersection.isEmpty
    }
}

public struct OpenWrappedIntegerSet<Element: BinaryInteger> {
    var wrappedIntegerSet: WrappedIntegerSet<Element>

    public init(
        start: Element,
        end: Element,
        maximum: Element
    ) {
        self.wrappedIntegerSet = .init(
            start: start,
            end: end,
            maximum: maximum,
            openClosed: .open
        )
    }

    public func isInWrappedRange(_ element: Element) -> Bool {
        wrappedIntegerSet.isInWrappedRange(element)
    }

    public func overlaps(
        _ openIntegerSet: OpenWrappedIntegerSet<Element>
    ) -> Bool {
        return wrappedIntegerSet.overlaps(
            openIntegerSet.wrappedIntegerSet
        )
    }
}

public struct ClosedWrappedIntegerSet<Element: BinaryInteger> {
    var wrappedIntegerSet: WrappedIntegerSet<Element>

    public init(
        start: Element,
        end: Element,
        maximum: Element
    ) {
        self.wrappedIntegerSet = .init(
            start: start,
            end: end,
            maximum: maximum,
            openClosed: .closed
        )
    }

    public func isInWrappedRange(_ element: Element) -> Bool {
        wrappedIntegerSet.isInWrappedRange(element)
    }

    public func overlaps(_ closedIntegerSet: ClosedWrappedIntegerSet) -> Bool {
        return wrappedIntegerSet.overlaps(
            closedIntegerSet.wrappedIntegerSet
        )
    }
}
