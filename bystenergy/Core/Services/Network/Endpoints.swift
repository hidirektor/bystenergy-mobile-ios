import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    // Auth
    case login(LoginRequest)
    case register(RegisterRequest)
    case refreshToken
    
    // User
    case userProfile
    case updateProfile(AppUser.UpdateRequest)
    case deleteAccount
    
    // Dashboard
    case dashboardData
    
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .register:
            return "auth/register"
        case .refreshToken:
            return "auth/refresh"
        case .userProfile:
            return "user/profile"
        case .updateProfile:
            return "user/profile/update"
        case .dashboardData:
            return "dashboard"
        case .deleteAccount:
            return "user/delete"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .register, .refreshToken:
            return .post
        case .userProfile:
            return .get
        case .updateProfile:
            return .put
        case .dashboardData:
            return .get
        case .deleteAccount:
            return .delete
        }
    }
    
    var body: Encodable? {
        switch self {
        case .login(let request):
            return request
        case .register(let request):
            return request
        case .updateProfile(let request):
            return request
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .dashboardData:
            return [
                URLQueryItem(name: "limit", value: "10"),
                URLQueryItem(name: "offset", value: "0")
            ]
        default:
            return nil
        }
    }
} 
