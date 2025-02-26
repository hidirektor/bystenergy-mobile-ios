import SwiftUI

struct OnboardingPageOne: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bolt.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.appPrimary)
            
            Text("Welcome to Byst Energy")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Monitor and manage your energy consumption in real-time")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
    }
} 