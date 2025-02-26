import SwiftUI

struct OnboardingPageTwo: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chart.bar.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.appPrimary)
            
            Text("Track Your Usage")
                .font(.title)
                .fontWeight(.bold)
            
            Text("View detailed analytics and insights about your energy consumption patterns")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
    }
} 