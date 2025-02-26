import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    let style: ButtonStyle
    let isLoading: Bool
    
    enum ButtonStyle {
        case primary
        case secondary
        case destructive
        
        var backgroundColor: Color {
            switch self {
            case .primary: return .appPrimary
            case .secondary: return .white
            case .destructive: return .appError
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .primary: return .white
            case .secondary: return .appPrimary
            case .destructive: return .white
            }
        }
        
        var borderColor: Color {
            switch self {
            case .primary: return .clear
            case .secondary: return .appPrimary
            case .destructive: return .clear
            }
        }
    }
    
    init(
        title: String,
        style: ButtonStyle = .primary,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: style.foregroundColor))
                        .padding(.trailing, 8)
                }
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: Constants.UI.buttonHeight)
            .foregroundColor(style.foregroundColor)
            .background(style.backgroundColor)
            .cornerRadius(Constants.UI.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                    .stroke(style.borderColor, lineWidth: 1)
            )
        }
        .disabled(isLoading)
    }
} 