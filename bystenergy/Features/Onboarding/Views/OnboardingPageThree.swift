import SwiftUI

struct OnboardingPageThree: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.appPrimary)
            
            Text("Save Energy & Money")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Get personalized recommendations to reduce your energy consumption and save money")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
    }
} 