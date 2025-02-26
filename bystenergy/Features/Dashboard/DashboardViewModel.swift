import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published private(set) var user: AppUser?
    @Published private(set) var statusCards: [StatusCardData] = []
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let apiManager: APIManager
    
    init(apiManager: APIManager = .shared) {
        self.apiManager = apiManager
    }
    
    func fetchDashboardData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let data: DashboardResponse = try await apiManager.request(.dashboardData)
            self.user = data.user
            self.statusCards = data.statusCards
        } catch {
            self.error = error
        }
    }
} 
