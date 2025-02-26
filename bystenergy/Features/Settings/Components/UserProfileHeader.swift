import SwiftUI

struct UserProfileHeader: View {
    let user: AppUser?
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.appPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user?.fullName ?? "User")
                    .font(.headline)
                
                Text(user?.email ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "pencil")
                    .foregroundColor(.appPrimary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserProfileHeader(user: nil)
} 