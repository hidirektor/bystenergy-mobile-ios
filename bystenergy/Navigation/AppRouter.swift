import SwiftUI

enum AppRouter {
    // Define all possible navigation paths
    enum Path: Hashable {
        case splash
        case onboarding
        case auth(AuthPath)
        case main(MainPath)
        
        enum AuthPath: Hashable {
            case login
            case register
            case forgotPassword
        }
        
        enum MainPath: Hashable {
            case dashboard
            case settings
            case profile
            case notifications
        }
    }
    
    // Define deep link handling
    enum DeepLink {
        case notification(id: String)
        case settings(section: String)
        case profile(userId: String)
        
        init?(url: URL) {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
                  let host = components.host else {
                return nil
            }
            
            switch host {
            case "notification":
                if let id = components.queryItems?.first(where: { $0.name == "id" })?.value {
                    self = .notification(id: id)
                } else {
                    return nil
                }
            case "settings":
                if let section = components.queryItems?.first(where: { $0.name == "section" })?.value {
                    self = .settings(section: section)
                } else {
                    return nil
                }
            case "profile":
                if let userId = components.queryItems?.first(where: { $0.name == "userId" })?.value {
                    self = .profile(userId: userId)
                } else {
                    return nil
                }
            default:
                return nil
            }
        }
    }
} 