import SwiftUI

struct CardStyle: ViewModifier {
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    init(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = Constants.UI.cornerRadius,
        shadowRadius: CGFloat = 4
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
    }
}

extension View {
    func cardStyle(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = Constants.UI.cornerRadius,
        shadowRadius: CGFloat = 4
    ) -> some View {
        modifier(CardStyle(
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            shadowRadius: shadowRadius
        ))
    }
} 