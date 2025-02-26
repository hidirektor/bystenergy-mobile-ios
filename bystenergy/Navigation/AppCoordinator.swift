import SwiftUI

extension NavigationPath {
    var lastRoute: AppRoute? {
        let mirror = Mirror(reflecting: self)
        if let array = mirror.children.first(where: { $0.label == "elements" })?.value as? [Any] {
            return array.last as? AppRoute
        }
        return nil
    }
}

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var selectedTab: Tab = .dashboard
    @Published private(set) var isPresented = false
    @Published private(set) var presentedSheet: Sheet?
    
    private let navigationState: NavigationState
    
    enum Tab {
        case dashboard
        case settings
    }
    
    enum Sheet: Identifiable {
        case profile
        case notifications
        case settings
        
        var id: String {
            switch self {
            case .profile: return "profile"
            case .notifications: return "notifications"
            case .settings: return "settings"
            }
        }
    }
    
    init(navigationState: NavigationState = NavigationState()) {
        self.navigationState = navigationState
    }
    
    // MARK: - Navigation Methods
    
    func start() {
        // Start with the splash screen
        navigationPath.append(AppRoute.splash)
    }
    
    func navigate(to route: AppRoute) {
        switch route {
        case .splash:
            // Prevent going back to splash after onboarding
            if let lastRoute = navigationPath.lastRoute, lastRoute != AppRoute.splash {
                navigationPath.append(AppRoute.splash)
            }
        case .onboarding:
            navigationPath.append(AppRoute.onboarding)
        case .auth(let authRoute):
            navigationPath.append(AppRoute.auth(authRoute))
        case .dashboard:
            navigationPath.append(AppRoute.dashboard)
        case .settings:
            navigationPath.append(AppRoute.settings)
        }
    }
    
    func navigateBack() {
        navigationPath.removeLast()
        navigationState.removeLastFromHistory()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
        navigationState.clearHistory()
    }
    
    func presentSheet(_ sheet: Sheet) {
        presentedSheet = sheet
        isPresented = true
    }
    
    func dismissSheet() {
        presentedSheet = nil
        isPresented = false
    }
    
    // MARK: - Deep Link Handling
    
    func handleDeepLink(_ deepLink: AppRouter.DeepLink) {
        switch deepLink {
        case .notification(_): // 'id' yerine '_' kullanıldı
            presentSheet(.notifications)
            // İlgili bildirimi göstermek için ek mantık eklenebilir
            
        case .settings(_): // 'section' yerine '_' kullanıldı
            selectedTab = .settings
            // Belirli bir ayar bölümünü göstermek için ek mantık eklenebilir
            
        case .profile(_): // 'userId' yerine '_' kullanıldı
            presentSheet(.profile)
            // Belirli bir profili göstermek için ek mantık eklenebilir
        }
    }
    
    // MARK: - View Factory
    
    func view(for route: AppRoute) -> some View {
        switch route {
        case .splash:
            return AnyView(SplashView())
        case .onboarding:
            return AnyView(OnboardingContainerView())
        case .auth(let authRoute):
            return AnyView(authView(for: authRoute))
        case .dashboard:
            return AnyView(DashboardView())
        case .settings:
            return AnyView(SettingsView())
        }
    }
    
    @ViewBuilder
    private func authView(for route: AppRoute.AuthRoute) -> some View {
        switch route {
        case .login:
            LoginView()
        case .register:
            RegisterView()
        case .forgotPassword:
            Text("Forgot Password") // Implement ForgotPasswordView
        }
    }
} 
