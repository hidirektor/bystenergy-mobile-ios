import SwiftUI

enum NotificationType {
    case success
    case error
    case warning
    case info
    
    var color: Color {
        switch self {
        case .success: return Color(.systemGreen)
        case .error: return Color(.systemRed)
        case .warning: return Color(.systemOrange)
        case .info: return Color(.systemBlue)
        }
    }
    
    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        }
    }
}

struct NotificationMessage: Identifiable {
    let id = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let duration: TimeInterval
    let isAutoDismiss: Bool
}

class NotificationService: ObservableObject {
    @Published private(set) var currentNotification: NotificationMessage?
    private var dismissTask: Task<Void, Never>?
    
    func show(
        type: NotificationType,
        title: String,
        message: String,
        duration: TimeInterval = 3.0,
        isAutoDismiss: Bool = true
    ) {
        dismissTask?.cancel()
        
        let notification = NotificationMessage(
            type: type,
            title: title,
            message: message,
            duration: duration,
            isAutoDismiss: isAutoDismiss
        )
        
        withAnimation {
            currentNotification = notification
        }
        
        if isAutoDismiss {
            dismissTask = Task {
                try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                await dismiss()
            }
        }
    }
    
    @MainActor
    func dismiss() {
        withAnimation {
            currentNotification = nil
        }
        dismissTask?.cancel()
        dismissTask = nil
    }
} 
