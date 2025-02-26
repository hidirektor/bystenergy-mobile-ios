import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    @UserDefault(key: "isOnboardingCompleted", defaultValue: false)
    var isOnboardingCompleted: Bool
    
    @UserDefault(key: "userTheme", defaultValue: "system")
    var userTheme: String
    
    @UserDefault(key: "lastLoginDate", defaultValue: nil)
    var lastLoginDate: Date?
    
    // Add generic set and get methods
    func set(_ value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func object(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    func array(forKey key: String) -> [[String: String]]? {
        return UserDefaults.standard.array(forKey: key) as? [[String: String]]
    }
    
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
} 
