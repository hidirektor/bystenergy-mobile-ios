import SwiftUI

struct ValidatedTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let validation: (String) throws -> Void
    
    @State private var errorMessage: String?
    @FocusState private var isFocused: Bool
    
    init(
        title: String,
        placeholder: String,
        text: Binding<String>,
        validation: @escaping (String) throws -> Void
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.validation = validation
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.secondary)
                .font(.caption)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isFocused)
                .onChange(of: text) {
                    validateInput()
                }
            
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private func validateInput() {
        do {
            try validation(text)
            errorMessage = nil
        } catch let validationError as ValidationError {
            errorMessage = validationError.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }
} 
