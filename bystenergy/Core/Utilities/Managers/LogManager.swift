import Foundation
import OSLog

enum LogLevel: String {
    case debug = "💚 DEBUG"
    case info = "💙 INFO"
    case warning = "💛 WARNING"
    case error = "❤️ ERROR"
    
    var osLogType: OSLogType {
        switch self {
        case .debug: return .debug
        case .info: return .info
        case .warning: return .error
        case .error: return .fault
        }
    }
}

final class LogManager {
    static let shared = LogManager()
    private let logger: Logger
    
    private init() {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.bystenergy", category: "app")
    }
    
    func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let fileName = (file as NSString).lastPathComponent
        let metadata = "[\(fileName):\(line)] \(function)"
        let fullMessage = "\(level.rawValue) \(metadata): \(message)"
        
        logger.log(level: level.osLogType, "\(fullMessage)")
        
        #if DEBUG
        print(fullMessage)
        #endif
    }
    
    // Convenience methods
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .debug, file: file, function: function, line: line)
    }
    
    func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }
    
    func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }
    
    func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
} 
