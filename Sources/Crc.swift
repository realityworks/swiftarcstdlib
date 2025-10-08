//
//  Crc.swift
//  swiftarcstdlib
//
//  Created by Piotr Suwara on 8/10/2025.
//

import Foundation
import zlib

extension Data {
    var crc32: UInt32 {
        self.withUnsafeBytes { buffer in
            let crc = zlib.crc32(0, buffer.bindMemory(to: Bytef.self).baseAddress, uInt(buffer.count))
            return UInt32(crc)
        }
    }
}
