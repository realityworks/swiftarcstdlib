//
//  Generatable.swift
//

import Foundation

public protocol Generatable {
    static var empty: Self { get }
    static var generated: Self { get }
}
