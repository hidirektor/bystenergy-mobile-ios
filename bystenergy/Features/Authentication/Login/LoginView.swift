import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Welcome Back")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(spacing: 16) {
                    ValidatedTextField(
                        title: "Email",
                        placeholder: "Enter your email",
                        text: $viewModel.email,
                        validation: validateEmail
                    )
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Forgot Password?") {
                        appCoordinator.navigate(to: .auth(.forgotPassword))
                    }
                    .font(.caption)
                }
                
                CustomButton(
                    title: "Sign In",
                    isLoading: viewModel.isLoading
                ) {
                    Task {
                        await viewModel.login()
                    }
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .alert("Error", isPresented: $viewModel.showError, presenting: viewModel.error) { _ in
            Button("OK", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
        .onChange(of: viewModel.isAuthenticated) {
            if viewModel.isAuthenticated {
                appCoordinator.navigate(to: .dashboard)
            }
        }
    }
    
    private func validateEmail(_ email: String) throws {
        try Validator.validate(email)
    }
}

#Preview {
    LoginView()
        .environmentObject(AppCoordinator())
} 
