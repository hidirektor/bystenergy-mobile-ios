import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var notificationService: NotificationService
    
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.currentPage) {
                OnboardingPageOne()
                    .tag(0)
                
                OnboardingPageTwo()
                    .tag(1)
                
                OnboardingPageThree()
                    .tag(2)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            VStack {
                // Skip button at top right
                HStack {
                    Spacer()
                    if !viewModel.isLastPage {
                        Button("Skip") {
                            viewModel.completeOnboarding()
                        }
                        .foregroundColor(.secondary)
                        .padding()
                    }
                }
                
                Spacer()
                
                // Navigation buttons at bottom
                HStack {
                    // Previous button (only for pages 2 and 3)
                    if viewModel.currentPage > 1 {
                        CustomButton(
                            title: "Previous",
                            style: .secondary
                        ) {
                            viewModel.previousPage()
                        }
                    }
                    
                    // Next/Get Started button
                    CustomButton(
                        title: viewModel.isLastPage ? "Get Started" : "Next",
                        style: .primary
                    ) {
                        if viewModel.isLastPage {
                            viewModel.completeOnboarding()
                        } else {
                            viewModel.nextPage()
                        }
                    }
                }
                .padding()
            }
            
            // Add NotificationBannerView
            NotificationBannerView()
        }
        .onChange(of: viewModel.isComplete) {
            if viewModel.isComplete {
                appCoordinator.navigate(to: .auth(.login))
            }
        }
    }
}

#Preview {
    OnboardingContainerView()
        .environmentObject(AppCoordinator())
        .environmentObject(NotificationService())
} 
