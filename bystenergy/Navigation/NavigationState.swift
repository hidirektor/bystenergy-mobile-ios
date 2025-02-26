import Foundation

final class NavigationState: ObservableObject {
    @Published private(set) var navigationHistory: [AppRoute] = []
    @Published private(set) var previousRoute: AppRoute?
    
    private let userDefaults: UserDefaultsManager
    private let maxHistoryItems = 50
    
    init(userDefaults: UserDefaultsManager = .shared) {
        self.userDefaults = userDefaults
        loadNavigationHistory()
    }
    
    // MARK: - History Management
    
    func addToHistory(_ route: AppRoute) {
        previousRoute = navigationHistory.last
        navigationHistory.append(route)
        
        // Limit history size
        if navigationHistory.count > maxHistoryItems {
            navigationHistory.removeFirst()
        }
        
        saveNavigationHistory()
    }
    
    func removeLastFromHistory() {
        guard !navigationHistory.isEmpty else { return }
        navigationHistory.removeLast()
        previousRoute = navigationHistory.last
        saveNavigationHistory()
    }
    
    func clearHistory() {
        navigationHistory.removeAll()
        previousRoute = nil
        saveNavigationHistory()
    }
    
    // MARK: - Persistence
    
    private func saveNavigationHistory() {
        let historyData = navigationHistory.map { route -> [String: String] in
            switch route {
            case .onboarding:
                return ["type": "onboarding"]
            case .auth(let authRoute):
                return ["type": "auth", "subtype": String(describing: authRoute)]
            case .dashboard:
                return ["type": "dashboard"]
            case .settings:
                return ["type": "settings"]
            case .splash: // Add missing case
                return ["type": "splash"]
            }
        }
        
        userDefaults.set(historyData, forKey: "navigation_history")
    }
    
    private func loadNavigationHistory() {
        guard let historyData = userDefaults.array(forKey: "navigation_history") else {
            return
        }
        
        navigationHistory = historyData.compactMap { data in
            guard let type = data["type"] else { return nil }
            
            switch type {
            case "onboarding":
                return .onboarding
            case "auth":
                guard let subtype = data["subtype"] else { return nil }
                switch subtype {
                case "login": return .auth(.login)
                case "register": return .auth(.register)
                case "forgotPassword": return .auth(.forgotPassword)
                default: return nil
                }
            case "dashboard":
                return .dashboard
            case "settings":
                return .settings
            default:
                return nil
            }
        }
        
        previousRoute = navigationHistory.last
    }
    
    // MARK: - Analytics
    
    func trackNavigation(_ route: AppRoute) {
        let screenName: String
        switch route {
        case .onboarding:
            screenName = "Onboarding"
        case .auth(let authRoute):
            screenName = "Auth_\(authRoute)"
        case .dashboard:
            screenName = "Dashboard"
        case .settings:
            screenName = "Settings"
        case .splash: // Add missing case
            screenName = "Splash"
        }

        AnalyticsService.shared.track(.screenView(screen: screenName))
    }
}
