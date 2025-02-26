import Foundation
import Combine

enum AuthenticationError: LocalizedError {
    case invalidCredentials
    case tokenExpired
    case networkError
    case unauthorized
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password"
        case .tokenExpired:
            return "Your session has expired. Please login again"
        case .networkError:
            return "Network error occurred. Please try again"
        case .unauthorized:
            return "Unauthorized access"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}

final class AuthenticationService: ObservableObject {
    static let shared = AuthenticationService()
    
    @Published private(set) var isAuthenticated = false
    @Published private(set) var currentUser: AppUser?
    @Published private(set) var isLoading = false
    
    private let apiManager: APIManager
    private let secureStorage: SecureStorageManager
    private let analytics: AnalyticsService
    private var cancellables = Set<AnyCancellable>()
    
    init(
        apiManager: APIManager = .shared,
        secureStorage: SecureStorageManager = .shared,
        analytics: AnalyticsService = .shared
    ) {
        self.apiManager = apiManager
        self.secureStorage = secureStorage
        self.analytics = analytics
        
        checkAuthenticationState()
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func login(email: String, password: String) async throws {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let request = LoginRequest(email: email, password: password)
            let response: AuthResponse = try await apiManager.request(.login(request))
            
            try await handleSuccessfulAuth(response)
            analytics.track(.userAction(action: "login_success", parameters: nil))
            
        } catch {
            analytics.track(.error(domain: "authentication", code: "login_failed", message: error.localizedDescription))
            throw handleAuthError(error)
        }
    }
    
    @MainActor
    func register(email: String, password: String, fullName: String) async throws {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let request = RegisterRequest(email: email, password: password, fullName: fullName)
            let response: AuthResponse = try await apiManager.request(.register(request))
            
            try await handleSuccessfulAuth(response)
            analytics.track(.userAction(action: "register_success", parameters: nil))
            
        } catch {
            analytics.track(.error(domain: "authentication", code: "register_failed", message: error.localizedDescription))
            throw handleAuthError(error)
        }
    }
    
    func logout() {
        do {
            try secureStorage.secureDelete(forKey: "auth_token")
            isAuthenticated = false
            currentUser = nil
            analytics.track(.userAction(action: "logout", parameters: nil))
            analytics.resetUser()
        } catch {
            print("Error during logout: \(error)")
        }
    }
    
    // MARK: - Private Methods
    
    private func checkAuthenticationState() {
        do {
            let tokenData: Data = try secureStorage.secureRetrieve(forKey: "auth_token")
            isAuthenticated = (String(data: tokenData, encoding: .utf8) != nil)
        } catch {
            isAuthenticated = false
            currentUser = nil
        }
    }
    
    private func handleAuthError(_ error: Error) -> AuthenticationError {
        switch error {
        case let apiError as APIError:
            switch apiError {
            case .unauthorized:
                return .invalidCredentials
            case .networkError:
                return .networkError
            default:
                return .unknown
            }
        default:
            return .unknown
        }
    }
    
    private func handleSuccessfulAuth(_ response: AuthResponse) async throws {
        let tokenData = Data(response.token.utf8)
        try secureStorage.secureStore(tokenData, forKey: "auth_token")
        currentUser = response.user
        isAuthenticated = true
        analytics.setUserID(response.user.id)
    }
} 
