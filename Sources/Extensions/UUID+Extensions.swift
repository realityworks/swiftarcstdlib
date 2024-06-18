//
//  UUID+Extensions.swift
//

import Foundation

extension UUID: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let uuid = UUID(uuidString: value) else {
            Logger.error(topic: .other, message: "Attempting to create a UUID with \(value) failed")
            self = UUID()
            return
        }

        self = uuid
    }
}
