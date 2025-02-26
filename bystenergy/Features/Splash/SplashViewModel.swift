import Foundation

@MainActor
class SplashViewModel: ObservableObject {
    @Published private(set) var nextRoute: AppRoute?
    
    private let userDefaults = UserDefaultsManager.shared
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = .shared) {
        self.authService = authService
    }
    
    func checkInitialState() async {
        // Simulate loading
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        if !userDefaults.isOnboardingCompleted {
            nextRoute = .onboarding
        } else if authService.isAuthenticated {
            nextRoute = .dashboard
        } else {
            nextRoute = .auth(.login)
        }
    }
} 