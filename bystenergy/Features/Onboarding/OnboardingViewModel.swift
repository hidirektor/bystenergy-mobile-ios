import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published private(set) var isComplete = false
    
    private let totalPages = 3
    private let userDefaults = UserDefaultsManager.shared
    
    var isLastPage: Bool {
        currentPage == totalPages - 1
    }
    
    func nextPage() {
        if currentPage < totalPages - 1 {
            currentPage += 1
        } else {
            completeOnboarding()
        }
    }
    
    func previousPage() {
        // Prevent going back from the first onboarding page
        if currentPage > 1 {
            currentPage -= 1
        }
    }
    
    func completeOnboarding() {
        userDefaults.isOnboardingCompleted = true
        isComplete = true
    }
} 