import SwiftUI

struct InAppNotification: View {
    let message: NotificationMessage
    let onDismiss: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: message.type.icon)
                .foregroundColor(message.type.color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.title)
                    .font(.headline)
                Text(message.message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if !message.isAutoDismiss {
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(Constants.UI.cornerRadius)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
} 