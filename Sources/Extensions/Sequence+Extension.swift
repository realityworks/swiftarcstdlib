//
//  Sequence+Extension.swift
//

import Foundation

public extension Sequence where Element: Hashable {

    ///
    /// Provide a subset of a sequence that contains only unique elements in an array.
    /// - Parameters:
    ///   - predicate: A predicate taking an element type returning a boolean if it is satisified.
    /// - Returns: An array of all unique elements of the sequence.
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }

    ///
    /// Check if any element in the sequence satisfies the predicate
    /// - Parameters:
    ///   - predicate: A predicate taking an element type returning a boolean if it is satisified.
    /// - Returns: A boolean indicating if there is at least one element satisfying the predicate.
    func anySatisfy(_ predicate: (Element)->Bool) -> Bool {
        for element in self {
            if predicate(element) {
                return true
            }
        }
        return false
    }
}
