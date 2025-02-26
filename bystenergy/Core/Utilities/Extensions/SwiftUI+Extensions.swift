import SwiftUI

extension Color {
    static let appPrimary = Color("PrimaryColor")
    static let appSecondary = Color("SecondaryColor")
    static let appBackground = Color("BackgroundColor")
    static let appError = Color("ErrorColor")
    static let appSuccess = Color("SuccessColor")
}

extension Image {
    func avatarStyle(size: CGFloat = 40) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

extension Text {
    func titleStyle() -> some View {
        self
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }
    
    func captionStyle() -> some View {
        self
            .font(.caption)
            .foregroundColor(.secondary)
    }
} 
