import Foundation

class SettingsViewModel: ObservableObject {
    @Published private(set) var user: bystenergy.AppUser?
    @Published private(set) var preferences: [SettingsItem] = []
    
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = .shared) {
        self.authService = authService
        self.user = authService.currentUser
        setupPreferences()
    }
    
    func signOut() {
        authService.logout()
    }
    
    private func setupPreferences() {
        preferences = [
            SettingsItem(title: "Notifications", icon: "bell.fill", action: {}),
            SettingsItem(title: "Privacy", icon: "lock.fill", action: {}),
            SettingsItem(title: "Help & Support", icon: "questionmark.circle.fill", action: {})
        ]
    }
} 
