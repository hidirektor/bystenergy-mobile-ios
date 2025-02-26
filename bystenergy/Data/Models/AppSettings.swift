import Foundation

struct AppSettings: Codable {
    var user: UserSettings
    var app: ApplicationSettings
    var notifications: NotificationSettings
    
    struct UserSettings: Codable {
        var isOnboardingCompleted: Bool
        var lastLoginDate: Date?
        var selectedTheme: Theme
        var selectedLanguage: String
        
        enum Theme: String, Codable {
            case system
            case light
            case dark
        }
    }
    
    struct ApplicationSettings: Codable {
        var isBiometricEnabled: Bool
        var isAnalyticsEnabled: Bool
        var isCrashReportingEnabled: Bool
        var cacheExpirationDays: Int
    }
    
    struct NotificationSettings: Codable {
        var isPushEnabled: Bool
        var isEmailEnabled: Bool
        var types: Set<NotificationType>
        
        enum NotificationType: String, Codable {
            case usage
            case billing
            case maintenance
            case tips
        }
    }
    
    static let `default` = AppSettings(
        user: UserSettings(
            isOnboardingCompleted: false,
            lastLoginDate: nil,
            selectedTheme: .system,
            selectedLanguage: "en"
        ),
        app: ApplicationSettings(
            isBiometricEnabled: true,
            isAnalyticsEnabled: true,
            isCrashReportingEnabled: true,
            cacheExpirationDays: 7
        ),
        notifications: NotificationSettings(
            isPushEnabled: true,
            isEmailEnabled: true,
            types: [.usage, .billing, .maintenance, .tips]
        )
    )
} 