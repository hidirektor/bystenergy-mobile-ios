import SwiftUI

struct LoadingIndicator: View {
    let message: String?
    let style: Style
    
    enum Style {
        case regular
        case overlay
        
        var backgroundColor: Color {
            switch self {
            case .regular: return .clear
            case .overlay: return Color.black.opacity(0.4)
            }
        }
    }
    
    init(message: String? = nil, style: Style = .regular) {
        self.message = message
        self.style = style
    }
    
    var body: some View {
        ZStack {
            if style == .overlay {
                style.backgroundColor
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)
                
                if let message = message {
                    Text(message)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
} 