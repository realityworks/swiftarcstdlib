//
//  Logger.swift
//

import Foundation

enum LoggerError: Error {
    case writeToLogFailed(String)
}

public struct Logger {
    static var maxLogLength: Int = 50_000
    static var crashOnDebugLogLevels: Set<Log.Level> = []
    static var reportableLogLevels: Set<Log.Level> = [.error]
    //public static var logQueue:
    public static var logEntries: [Log] = []
    static let queue = DispatchQueue(label: "thread-safe-logger", attributes: .concurrent)

    public static func writeLogTo(fileUrl url: URL) throws {
        // Write log entries to one string.
        let allLogString = logEntries.reduce("") { partialResult, nextLogEntry in
            partialResult + "\(nextLogEntry.output)\n"
        }

        guard let logData = allLogString.data(using: .utf8) else {
            throw LoggerError.writeToLogFailed("Could not convert log string to data!")
        }

        // Write the string to a file from the URL.
        try logData.write(to: url)
    }

    static func log(level: Log.Level, topic: Log.Topic, message: String) {
        let log = Log(level: level, topic: topic, message: message)
        if shouldPrintLog(for: level) {
            print(log.output)
        }
        assert(!crashOnDebugLogLevels.contains(level), message)

        // Perform a threadsafe write
        queue.sync(flags: .barrier) {
            // perform writes on data
            logEntries.append(log)

            while logEntries.count > Self.maxLogLength {
                logEntries.removeFirst()
            }
        }
    }

    public static var dateStyle: DateFormatter.Style = .short {
        didSet {
            dateFormatter.dateStyle = dateStyle
        }
    }
    
    public static var timeStyle: DateFormatter.Style = .short {
        didSet {
            dateFormatter.timeStyle = timeStyle
        }
    }
    
    fileprivate static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM HH:mm:ss.SSS"
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter
    }()

    public static func error(topic: Log.Topic, message: String) {
        Logger.log(level: .error, topic: topic, message: message)
    }

    public static func warning(topic: Log.Topic, message: String) {
        Logger.log(level: .warning, topic: topic, message: message)
    }

    public static func info(topic: Log.Topic, message: String) {
        Logger.log(level: .info, topic: topic, message: message)
    }

    public static func verbose(topic: Log.Topic, message: String) {
        Logger.log(level: .verbose, topic: topic, message: message)
    }

    public static func printing(logLevel: Log.Level, isEnabled enabled: Bool) {
        printLogLevelEnabled[logLevel] = enabled
    }

    private static var printLogLevelEnabled: [Log.Level: Bool] = [
        .error: true,
        .warning: true,
        .info: true
    ]

    private static func shouldPrintLog(for level: Log.Level) -> Bool {
        return printLogLevelEnabled[level] ?? false
    }
}

// MARK: - Log

public struct Log {
    let timestamp: Date = Date()
    let level: Level
    let topic: Topic
    let message: String

    public var output: String {
        let date = Logger.dateFormatter.string(from: timestamp)
        return "LOG: [\(date)] [\(level.rawValue)] \(topic.rawValue): \(message)"
    }

    var userInfo: [String: Any] {
        [
            "level": level.rawValue,
            "topic": topic.rawValue,
            "message": message,
        ]
    }

    public enum Topic: String {
        case appState = "App State"
        case usecase = "Use Case"
        case authentication = "Authentication"
        case cloudData = "Cloud Data"
        case service = "Service"
        case hardware = "Hardware"
        case other = "Other"
        case debug = "Debug"
        
        var shortDescription: String {
            switch self {
            case .appState: return "APP"
            case .usecase: return "USECASE"
            case .authentication: return "AUTH"
            case .cloudData: return "CLOUD"
            case .service: return "SERVICE"
            case .hardware: return "HW"
            case .other: return "OTHER"
            case .debug: return "DBG"
            }
        }
    }

    public enum Level: String {
        case error = "🔴 Error  "
        case warning = "🔶 Warning"
        case info = "🔵 Info   "
        case verbose = "⚪️ Verbose"
    }
}

