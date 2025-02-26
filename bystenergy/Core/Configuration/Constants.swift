import UIKit

enum Constants {
    enum API {
        static let timeout: TimeInterval = AppConfiguration.shared.networkTimeout
        static let defaultHeaders: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "App-Version": AppConfiguration.shared.appVersion,
            "Platform": "iOS"
        ]
        
        static let maxRetryAttempts = 3
        static let retryDelay: TimeInterval = 2.0
    }
    
    enum Storage {
        static let userDefaultsSuite = "com.bystenergy.app"
        static let keychainService = "com.bystenergy.keychain"
        static let maxCacheSize = 50 * 1024 * 1024 // 50MB
    }
    
    enum UI {
        static let cornerRadius: CGFloat = 8
        static let buttonHeight: CGFloat = 50
        static let spacing: CGFloat = 16
        static let padding: CGFloat = 20
        
        enum Animation {
            static let duration: TimeInterval = 0.3
            static let delay: TimeInterval = 0.0
        }
        
        enum Font {
            static let titleSize: CGFloat = 24
            static let bodySize: CGFloat = 16
            static let captionSize: CGFloat = 12
        }
        
        enum Color {
            static let primary = "PrimaryColor"
            static let secondary = "SecondaryColor"
            static let background = "BackgroundColor"
            static let error = "ErrorColor"
            static let success = "SuccessColor"
        }
    }
    
    enum Validation {
        static let minPasswordLength = 8
        static let maxPasswordLength = 32
        static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let phoneRegex = "^[0-9]{10}$"
    }
    
    enum DateFormat {
        static let api = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let display = "MMM dd, yyyy"
        static let time = "HH:mm"
    }
    
    enum Analytics {
        static let maxEventProperties = 100
        static let maxUserProperties = 50
        
        enum EventName {
            static let appLaunch = "app_launch"
            static let login = "user_login"
            static let signup = "user_signup"
            static let logout = "user_logout"
            static let viewScreen = "view_screen"
            static let buttonClick = "button_click"
        }
    }
    
    enum Cache {
        static let maxAge: TimeInterval = AppConfiguration.shared.maxCacheAge
        static let maxSize = 100 * 1024 * 1024 // 100MB
    }
} 