import Foundation

enum AnalyticsEvent {
    case screenView(screen: String)
    case buttonTap(button: String)
    case userAction(action: String, parameters: [String: Any]?)
    case error(domain: String, code: String, message: String)
    
    var name: String {
        switch self {
        case .screenView: return "screen_view"
        case .buttonTap: return "button_tap"
        case .userAction: return "user_action"
        case .error: return "error"
        }
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [
            "timestamp": Date().timeIntervalSince1970,
            "event_name": name
        ]
        
        switch self {
        case .screenView(let screen):
            params["screen_name"] = screen
            
        case .buttonTap(let button):
            params["button_name"] = button
            
        case .userAction(_, let parameters):
            if let parameters = parameters {
                params.merge(parameters) { current, _ in current }
            }
            
        case .error(let domain, let code, let message):
            params["error_domain"] = domain
            params["error_code"] = code
            params["error_message"] = message
        }
        
        return params
    }
}

final class AnalyticsService {
    static let shared = AnalyticsService()
    private var isEnabled: Bool
    
    private init() {
        self.isEnabled = AppConfiguration.shared.isAnalyticsEnabled
    }
    
    func configure() {
        // Initialize analytics SDK here
        isEnabled = AppConfiguration.shared.isAnalyticsEnabled
    }
    
    func track(_ event: AnalyticsEvent) {
        guard isEnabled else { return }
        
        #if DEBUG
        print("Analytics Event:", event.name)
        print("Parameters:", event.parameters)
        #endif
        
        // Send event to analytics service
        // Example: FirebaseAnalytics.logEvent(event.name, parameters: event.parameters)
    }
    
    func setUserProperty(_ value: String, forName name: String) {
        guard isEnabled else { return }
        // Set user property in analytics service
    }
    
    func setUserID(_ userID: String) {
        guard isEnabled else { return }
        // Set user ID in analytics service
    }
    
    func resetUser() {
        guard isEnabled else { return }
        // Reset user in analytics service
    }
} 
