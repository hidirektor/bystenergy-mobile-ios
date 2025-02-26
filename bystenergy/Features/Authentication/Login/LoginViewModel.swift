import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: Error?
    @Published var isAuthenticated = false
    
    var showError: Bool {
        get { error != nil }
        set { if !newValue { error = nil } }
    }
    
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = .shared) {
        self.authService = authService
    }
    
    func login() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await authService.login(email: email, password: password)
            isAuthenticated = true
        } catch {
            self.error = error
        }
    }
} 