import SwiftUI

@main
struct bystenergyApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var authService = AuthenticationService()
    @StateObject private var notificationService = NotificationService()
    
    init() {
        setupAppearance()
        setupServices()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.navigationPath) {
                SplashView()
                    .navigationDestination(for: AppRoute.self) { route in
                        appCoordinator.view(for: route)
                    }
            }
            .environmentObject(appCoordinator)
            .environmentObject(authService)
            .environmentObject(notificationService)
            .overlay(alignment: .top) {
                NotificationBannerView()
                        .environmentObject(notificationService)
            }
        }
    }
    
    private func setupAppearance() {
        // Configure global appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func setupServices() {
        NetworkMonitor.shared.startMonitoring()
        AnalyticsService.shared.configure()
    }
} 
