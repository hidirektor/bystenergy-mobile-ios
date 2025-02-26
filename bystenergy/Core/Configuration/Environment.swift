enum Environment {
    case development
    case staging
    case production
    
    static var current: Environment {
        #if DEBUG
        return .development
        #elseif STAGING
        return .staging
        #else
        return .production
        #endif
    }
    
    var name: String {
        switch self {
        case .development:
            return "Development"
        case .staging:
            return "Staging"
        case .production:
            return "Production"
        }
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://dev-api.bystenergy.com"
        case .staging:
            return "https://staging-api.bystenergy.com"
        case .production:
            return "https://api.bystenergy.com"
        }
    }
} 