//
//  FixedSizeASCIIString.swift
//  
//
//  Created by Piotr Suwara on 1/2/2023.
//

import Foundation

public protocol FixedSizeASCIIString: ExpressibleByStringLiteral, CustomStringConvertible, DataDefinable, Equatable {
    // The size in characters
    static var size: UInt16 { get }
    var stringRepresentation: String { get set }
    var string: String { get }
    var asData: Data { get }
    init()
}

extension FixedSizeASCIIString {
    public init(stringLiteral value: String) {
        self.init()

        let asciiCharacters = value.filter( { $0.isASCII })
        let trimmedAsciiCharacters = asciiCharacters.prefix(Int(Self.size))
        let sourceArray = Array(String(trimmedAsciiCharacters).utf8)

        var destinationArray = Array<UInt8>(repeating: 0, count: Int(Self.size))

        sourceArray.withUnsafeBytes { sourcePointer in
            destinationArray.withUnsafeMutableBytes { destinationPointer in
                destinationPointer.copyMemory(from: sourcePointer)
            }
        }

        self.stringRepresentation = String(bytes: destinationArray, encoding: .ascii) ?? String()
    }

    public var description: String {
        string
    }

    var nativeString: String {
        stringRepresentation.replacingOccurrences(of: "\0", with: "")
    }

    public var asData: Data {
        let bytes = Array(stringRepresentation.utf8).map { UInt8($0) }
        return Data(bytes)
    }

    static func ==(
        lhs: Self,
        rhs: any FixedSizeASCIIString
    ) -> Bool {
        return lhs.stringRepresentation == rhs.stringRepresentation
    }
}

public struct ASCIIString6: FixedSizeASCIIString {
    public static var size: UInt16 { 6 }
    public var stringRepresentation: String = ""
    public var string: String { nativeString }
    public init() { }
}

public struct ASCIIString8: FixedSizeASCIIString {
    public static var size: UInt16 { 8 }
    public var stringRepresentation: String = ""
    public var string: String { nativeString }
    public init() { }
}

public struct ASCIIString16: FixedSizeASCIIString {
    public static var size: UInt16 { 16 }
    public var stringRepresentation: String = ""
    public var string: String { nativeString }
    public init() { }
}

public struct ASCIIString32: FixedSizeASCIIString {
    public static var size: UInt16 { 32 }
    public var stringRepresentation: String = ""
    public var string: String { nativeString }
    public init() { }
}
