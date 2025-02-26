import SwiftUI

struct SettingsItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let action: () -> Void
}

struct SettingsRow: View {
    let item: SettingsItem
    
    var body: some View {
        Button(action: item.action) {
            HStack {
                Image(systemName: item.icon)
                    .foregroundColor(.appPrimary)
                    .frame(width: 24)
                
                Text(item.title)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
    }
} 