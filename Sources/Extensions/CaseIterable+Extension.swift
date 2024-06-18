//
//  CaseIterable+Extension.swift
//

import Foundation

extension CaseIterable where Self: Hashable {
    public static var randomSetOfCases: Set<Self> {
        .init(
            Self.allCases.filter {
                _ in Bool.random()
            }
        )
    }
}
