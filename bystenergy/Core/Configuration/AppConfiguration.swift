import Foundation

final class AppConfiguration {
    static let shared = AppConfiguration()
    
    private init() {}
    
    // API Configuration
    var environment: Environment {
        Environment.current
    }
    
    var baseURL: String {
        environment.baseURL
    }
    
    var apiVersion: String {
        "v1"
    }
    
    // App Configuration
    var appName: String {
        Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Byst Energy"
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    // Feature Flags
    var isAnalyticsEnabled: Bool {
        environment != .development
    }
    
    var isCrashReportingEnabled: Bool {
        environment != .development
    }
    
    // Timeouts
    var networkTimeout: TimeInterval {
        environment == .development ? 60 : 30
    }
    
    // Cache Configuration
    var maxCacheAge: TimeInterval {
        24 * 60 * 60 // 24 hours
    }
} 