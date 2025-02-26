import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(spacing: 16) {
                    ValidatedTextField(
                        title: "Full Name",
                        placeholder: "Enter your full name",
                        text: $viewModel.fullName,
                        validation: validateName
                    )
                    
                    ValidatedTextField(
                        title: "Email",
                        placeholder: "Enter your email",
                        text: $viewModel.email,
                        validation: validateEmail
                    )
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                CustomButton(
                    title: "Create Account",
                    isLoading: viewModel.isLoading
                ) {
                    Task {
                        await viewModel.register()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Sign Up")
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
    
    private func validateName(_ name: String) throws {
        guard !name.isEmpty else {
            throw ValidationError.emptyField("Full Name")
        }
    }
    
    private func validateEmail(_ email: String) throws {
        try Validator.validate(email)
    }
}

#Preview {
    RegisterView()
        .environmentObject(AppCoordinator())
} 
