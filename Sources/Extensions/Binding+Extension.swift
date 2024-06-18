//
//  Binding+Extension.swift
//

import SwiftUI

public extension Binding {
    static func convert<IntType, FloatType>(
        from binding: Binding<IntType>
    ) -> Binding<FloatType> where IntType: BinaryInteger, FloatType: BinaryFloatingPoint {
        Binding<FloatType> (
            get: {
                FloatType(binding.wrappedValue)
            },
            set: {
                binding.wrappedValue = IntType($0)
            }
        )
    }

    static func convert<IntType, FloatType>(
        from binding: Binding<FloatType>
    ) -> Binding<IntType> where FloatType: BinaryFloatingPoint, IntType: BinaryInteger {
        Binding<IntType> (
            get: {
                IntType(binding.wrappedValue)
            },
            set: {
                binding.wrappedValue = FloatType($0)
            }
        )
    }
}
