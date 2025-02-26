import SwiftUI

struct DashboardHeader: View {
    let user: AppUser?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome back,")
                        .foregroundColor(.secondary)
                    Text(user?.fullName ?? "User")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.appPrimary)
            }
            
            Divider()
        }
    }
}

#Preview {
    DashboardHeader(user: nil)
} 