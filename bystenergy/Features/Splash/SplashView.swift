import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            Color.appPrimary
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("logo_byst")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 200)
            }
        }
        .task {
            await viewModel.checkInitialState()
        }
        .onChange(of: viewModel.nextRoute) {
            if let route = viewModel.nextRoute {
                appCoordinator.navigate(to: route)
            }
        }
    }
} 
