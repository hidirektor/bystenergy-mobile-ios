import Foundation

public struct AppUser: Codable, Identifiable {
    public let id: String
    public let email: String
    public let fullName: String
    public let phoneNumber: String?
    public let profileImageURL: URL?
    public let createdAt: Date
    public let lastLoginAt: Date?
    public var preferences: UserPreferences
    
    public struct UserPreferences: Codable {
        public var notificationsEnabled: Bool
        public var darkModeEnabled: Bool
        public var emailSubscribed: Bool
        public var language: String
        
        public init(
            notificationsEnabled: Bool = true,
            darkModeEnabled: Bool = false,
            emailSubscribed: Bool = true,
            language: String = "en"
        ) {
            self.notificationsEnabled = notificationsEnabled
            self.darkModeEnabled = darkModeEnabled
            self.emailSubscribed = emailSubscribed
            self.language = language
        }
    }
    
    public init(
        id: String,
        email: String,
        fullName: String,
        phoneNumber: String? = nil,
        profileImageURL: URL? = nil,
        createdAt: Date = Date(),
        lastLoginAt: Date? = nil,
        preferences: UserPreferences = UserPreferences()
    ) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.profileImageURL = profileImageURL
        self.createdAt = createdAt
        self.lastLoginAt = lastLoginAt
        self.preferences = preferences
    }
}

// MARK: - API Models
extension AppUser {
    public struct CreateRequest: Encodable {
        public let email: String
        public let password: String
        public let fullName: String
        
        public init(email: String, password: String, fullName: String) {
            self.email = email
            self.password = password
            self.fullName = fullName
        }
    }
    
    public struct UpdateRequest: Encodable {
        public let fullName: String?
        public let phoneNumber: String?
        public let preferences: UserPreferences?
        
        public init(
            fullName: String? = nil,
            phoneNumber: String? = nil,
            preferences: UserPreferences? = nil
        ) {
            self.fullName = fullName
            self.phoneNumber = phoneNumber
            self.preferences = preferences
        }
    }
} 
