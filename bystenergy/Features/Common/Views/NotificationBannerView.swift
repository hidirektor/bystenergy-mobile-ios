import SwiftUI

struct NotificationBannerView: View {
    @EnvironmentObject private var notificationService: NotificationService
    @State private var offset: CGFloat = -100
    
    var body: some View {
        Group {
            if let notification = notificationService.currentNotification {
                InAppNotification(
                    message: notification,
                    onDismiss: {
                        notificationService.dismiss()
                    }
                )
                .transition(.move(edge: .top))
                .offset(y: offset)
                .onAppear {
                    withAnimation(.spring()) {
                        offset = 0
                    }
                }
                .onDisappear {
                    offset = -100
                }
            }
        }
        .padding(.top, UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .safeAreaInsets.top ?? 0)
    }
}

#Preview {
    NotificationBannerView()
        .environmentObject(NotificationService())
} 
