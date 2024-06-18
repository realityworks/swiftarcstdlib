//
//  Task+Extension.swift
//

import Foundation

extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds duration: TimeInterval) async throws {
        try await Task.sleep(nanoseconds: UInt64(duration.asNanoseconds))
    }
}
