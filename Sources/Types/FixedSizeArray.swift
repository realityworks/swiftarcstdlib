//
//  FixedSizeArray.swift
//
//
//  Created by Piotr Suwara on 2/2/2023.
//

import Foundation

public protocol FixedSizeArray: ExpressibleByArrayLiteral {
    associatedtype Element = ArrayLiteralElement
    static var size: UInt32 { get }
    var array: Array<Element> { get set }
    var asData: Data { get }
    init()
    
    // Common sequence and array details
    subscript(index: Int) -> Element { get set }
}

extension FixedSizeArray where Self: Equatable, Self.Element: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.array == rhs.array
    }
}


public extension FixedSizeArray {
    init(arrayLiteral elements: Element...) {
        self.init()

        // We need to set this here because otherwise the type complains we haven't set everything before our call.
        self.array = elements
        updateArrayFrom(elements: array)
    }

    subscript(index: Int) -> Element {
        get {
            array[index]
        }
        set {
            guard index < Self.size else {
                fatalError("Index into fixed size array out of bounds!")
            }

            array[index] = newValue
        }
    }

    mutating func updateArrayFrom(elements: Array<Element>) {
        let trimmedElements = elements.prefix(Int(Self.size))
        let bufferCapacity = Int(Self.size) * MemoryLayout<Element>.size
        self.array = Array<Element>(
            unsafeUninitializedCapacity: bufferCapacity,
            initializingWith: { destinationBuffer, initializedCount in
                let destPointer = destinationBuffer.baseAddress

                trimmedElements.withUnsafeBytes { sourceBuffer in
                    let srcPointer = sourceBuffer.baseAddress

                    memset(destPointer, 0, bufferCapacity)
                    memcpy(destPointer, srcPointer, trimmedElements.count * MemoryLayout<Element>.size)
                }

                initializedCount = Int(Self.size)
            }
        )
    }

    init(elements: [Element]) {
        self.init()
        self.array = elements
        updateArrayFrom(elements: elements)
    }

    var asData: Data {
        let data = array.withUnsafeBytes { bufferPointer in
            Data(bufferPointer)
        }
        return data
    }
}

public extension FixedSizeArray where Element: DataDefinable {
    var asData: Data {
        var data = Data()
        for element in self.array {
            data.append(element)
        }
        return data
    }
}

public struct Array196<Element>: FixedSizeArray {
    public static var size: UInt32 { 196 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array192<Element>: FixedSizeArray {
    public static var size: UInt32 { 192 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array160<Element>: FixedSizeArray {
    public static var size: UInt32 { 160 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array170<Element>: FixedSizeArray {
    public static var size: UInt32 { 170 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array80<Element>: FixedSizeArray {
    public static var size: UInt32 { 80 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array40<Element>: FixedSizeArray {
    public static var size: UInt32 { 40 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array32<Element>: FixedSizeArray {
    public static var size: UInt32 { 32 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array30<Element>: FixedSizeArray {
    public static var size: UInt32 { 30 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array24<Element>: FixedSizeArray {
    public static var size: UInt32 { 24 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}


public struct Array16<Element>: FixedSizeArray {
    public static var size: UInt32 { 16 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array15<Element>: FixedSizeArray {
    public static var size: UInt32 { 15 }
    public var itrIndex = 0
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array14<Element>: FixedSizeArray {
    public static var size: UInt32 { 14 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public struct Array8<Element>: FixedSizeArray {
    public static var size: UInt32 { 8 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

public extension Array8 where Element: FixedWidthInteger {
    var asData: Data {
        let data = array.withUnsafeBytes { bufferPointer in
            Data(bufferPointer)
        }
        return data
    }
}

extension Array8: Equatable where Self.Element: Equatable {}

public struct Array4<Element>: FixedSizeArray {
    public static var size: UInt32 { 4 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

extension Array4: Equatable where Self.Element: Equatable {}

public struct Array2<Element>: FixedSizeArray {
    public static var size: UInt32 { 2 }
    public var array: Array<Element> = []
    public init() { updateArrayFrom(elements: []) }
}

extension Array2: Equatable where Self.Element: Equatable {}


