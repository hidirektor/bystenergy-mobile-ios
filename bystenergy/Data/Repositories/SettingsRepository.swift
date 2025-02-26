import Foundation

protocol SettingsRepositoryProtocol {
    func getSettings() throws -> AppSettings
    func updateSettings(_ settings: AppSettings) throws
    func resetSettings() throws
}

final class SettingsRepository: SettingsRepositoryProtocol {
    private let userDefaults: UserDefaultsManager
    private let secureStorage: SecureStorageManager
    
    init(
        userDefaults: UserDefaultsManager = .shared,
        secureStorage: SecureStorageManager = .shared
    ) {
        self.userDefaults = userDefaults
        self.secureStorage = secureStorage
    }
    
    func getSettings() throws -> AppSettings {
        if let data = try? secureStorage.secureRetrieve(forKey: "app_settings") {
            return try JSONDecoder().decode(AppSettings.self, from: data)
        }
        return AppSettings.default
    }
    
    func updateSettings(_ settings: AppSettings) throws {
        let data = try JSONEncoder().encode(settings)
        try secureStorage.secureStore(data, forKey: "app_settings")
        
        // Update UserDefaults for frequently accessed settings
        userDefaults.isOnboardingCompleted = settings.user.isOnboardingCompleted
        userDefaults.userTheme = settings.user.selectedTheme.rawValue
    }
    
    func resetSettings() throws {
        try updateSettings(AppSettings.default)
    }
} 