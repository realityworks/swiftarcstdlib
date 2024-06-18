//
//  TimeoutTask.swift
//  
//

import Foundation

public actor TimeoutTask<Success> {
    let nanoseconds: UInt64
    let operation: @Sendable () async throws -> Success
    private var continuation: CheckedContinuation<Success, Error>?

    public init(seconds: TimeInterval, operation: @escaping @Sendable () async throws -> Success) {
        self.nanoseconds = UInt64(seconds * 1_000_000_000)
        self.operation = operation
    }

    public var value: Success {
        get async throws {
            return try await withCheckedThrowingContinuation({ continuation in
                self.continuation = continuation

                // Timer task
                Task {
                    try? await Task.sleep(nanoseconds: nanoseconds)

                    self.continuation?.resume(throwing: TimeoutError())
                    self.continuation = nil
                }

                // Operation task
                Task {
                    do {
                        let result = try await operation()
                        self.continuation?.resume(returning: result)
                    } catch {
                        self.continuation?.resume(throwing: error)
                    }

                    self.continuation = nil
                }
            })
        }
    }
}

public extension TimeoutTask {
    struct TimeoutError: LocalizedError {
        public var errorDescription: String? {
            "Operation timed out..."
        }
    }
}
