import Foundation

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
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
    
    func register() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try Validator.validate(password: password, confirmPassword: confirmPassword)
            try await authService.register(email: email, password: password, fullName: fullName)
            isAuthenticated = true
        } catch {
            self.error = error
        }
    }
} 