import SwiftUI

extension View {
    func cardStyle(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = Constants.UI.cornerRadius
    ) -> some View {
        self
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: 2)
    }
    
    func loadingOverlay(_ isLoading: Bool) -> some View {
        self.overlay(
            Group {
                if isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                        )
                }
            }
        )
    }
    
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedError = error.wrappedValue as? LocalizedError
        
        return alert(
            "Error",
            isPresented: .constant(error.wrappedValue != nil),
            presenting: localizedError
        ) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.errorDescription ?? "An unknown error occurred")
        }
    }
} 
