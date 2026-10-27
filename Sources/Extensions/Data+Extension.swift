//
//  Data+Extension.swift
//  
//
//  Created by Piotr Suwara on 1/2/2023.
//

import Foundation

// MARK: - Initialisers
public extension Data {
    init(_ dataDefinable: any DataDefinable) {
        self = dataDefinable.asData
    }
    
    init(_ fixedWidthInteger: any FixedWidthInteger) {
        self = fixedWidthInteger.asData
    }
}

// MARK: Append data 

public extension Data {
    mutating func append<T: FixedSizeArray>(_ fixedSizedArray: T) where T.Element: FixedWidthInteger {
        fixedSizedArray.array.forEach { append($0) }
    }

    mutating func append<T: FixedSizeArray>(_ fixedSizedArray: T) where T.Element: DataDefinable {
        fixedSizedArray.array.forEach { append($0) }
    }

    mutating func append(_ fixedWidthInteger: any FixedWidthInteger) {
        append(fixedWidthInteger.asData)
    }

    mutating func append<T: DataDefinable>(_ dataDefinable: T) {
        append(dataDefinable.asData)
    }
}

// MARK: - Data type converstions

public extension Data {
    func byteArray(size: UInt64, at byteOffset: UInt64) throws -> [UInt8] {
        // Pull the bytes from the firmware data
        try self.withUnsafeBytes { rawBufferPointer in
            guard let unsafePointer = rawBufferPointer.bindMemory(to: UInt8.self).baseAddress else {
                throw IntelliIQDataError.memoryBindingError
            }

            let u8Buffer = UnsafeBufferPointer<UInt8>(start: unsafePointer + Int(byteOffset), count: Int(size))
            return Array(u8Buffer)
        }
    }

    func to<T>(_ type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }

    func to<T: FixedWidthInteger>(at byteOffset: UInt64, as: T.Type) throws -> T {
        var value: T = 0

        //Copy the misaligned bytes at `offset` to aligned region `value`
        _ = Swift.withUnsafeMutableBytes(of: &value) { valueBufferPointer in
            self.withUnsafeBytes { rawBufferPointer in
                let range = Int(byteOffset)..<Int(byteOffset)+MemoryLayout<T>.size
                rawBufferPointer.copyBytes(to: valueBufferPointer, from: range)
            }
        }

        return value.littleEndian
    }

    func toBigEndian<T: FixedWidthInteger>(_ type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }.bigEndian
    }

    func toLittleEndian<T: FixedWidthInteger>(_ type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }.littleEndian
    }

    // Grab a type inside a data block at an intermediate position
    func to<T>(at byteOffset: UInt64, as: T.Type) throws -> T {
        try self.withUnsafeBytes { rawBufferPointer in
            guard let unsafePointer = rawBufferPointer.bindMemory(to: UInt8.self).baseAddress else {
                throw IntelliIQDataError.memoryBindingError
            }

            let bufferPointer = UnsafeBufferPointer<UInt8>(start: unsafePointer + Int(byteOffset), count: 1)
            let typePointer = bufferPointer.withMemoryRebound(to: T.self) { buffer in
                buffer
            }

            guard let baseAddress = typePointer.baseAddress else {
                throw IntelliIQDataError.memoryOffsetMismatch
            }

            return baseAddress.pointee
        }
    }

    // A hexadecimal string representation of the bytes.
    func hexString() -> String {
        let hexDigits = Array("0123456789abcdef".utf16)
        var hexChars = [UTF16.CodeUnit]()
        hexChars.reserveCapacity(count * 2)

        for byte in self {
            let (index1, index2) = Int(byte).quotientAndRemainder(dividingBy: 16)
            hexChars.append(hexDigits[index1])
            hexChars.append(hexDigits[index2])
        }

        return String(utf16CodeUnits: hexChars, count: hexChars.count)
    }

    var bytesArray: [UInt8] {
        [UInt8](self)
    }
}
