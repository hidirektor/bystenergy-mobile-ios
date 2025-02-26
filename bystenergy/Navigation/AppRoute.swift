import Foundation

enum AppRoute: Hashable {
    case splash
    case onboarding
    case auth(AuthRoute)
    case dashboard
    case settings
    
    enum AuthRoute: Hashable {
        case login
        case register
        case forgotPassword
    }
} 