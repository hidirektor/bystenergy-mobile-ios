import SwiftUI

struct AuthSelectionView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            
            Text("Welcome to Byst Energy")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Please sign in or create an account to continue")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            VStack(spacing: 16) {
                CustomButton(title: "Sign In") {
                    appCoordinator.navigate(to: .auth(.login))
                }
                
                CustomButton(title: "Create Account", style: .secondary) {
                    appCoordinator.navigate(to: .auth(.register))
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
} 