//
//  FixedWidthInteger+Extension.swift
//  
//
//  Created by Piotr Suwara on 1/2/2023.
//

import Foundation

public extension FixedWidthInteger {
    var asData: Data {
        var value = self.littleEndian
        return Data(bytes: &value, count: MemoryLayout<Self>.size)
    }
}
