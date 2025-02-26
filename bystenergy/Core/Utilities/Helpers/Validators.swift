import Foundation

enum ValidationError: LocalizedError {
    case invalidEmail
    case invalidPassword
    case passwordsDontMatch
    case emptyField(String)
    case invalidPhoneNumber
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address"
        case .invalidPassword:
            return "Password must be between \(Constants.Validation.minPasswordLength) and \(Constants.Validation.maxPasswordLength) characters"
        case .passwordsDontMatch:
            return "Passwords don't match"
        case .emptyField(let fieldName):
            return "\(fieldName) cannot be empty"
        case .invalidPhoneNumber:
            return "Please enter a valid phone number"
        }
    }
}

struct Validator {
    static func validate(_ email: String) throws {
        guard !email.isEmpty else {
            throw ValidationError.emptyField("Email")
        }
        guard email.isValidEmail else {
            throw ValidationError.invalidEmail
        }
    }
    
    static func validate(password: String) throws {
        guard !password.isEmpty else {
            throw ValidationError.emptyField("Password")
        }
        guard password.isValidPassword else {
            throw ValidationError.invalidPassword
        }
    }
    
    static func validate(password: String, confirmPassword: String) throws {
        try validate(password: password)
        guard password == confirmPassword else {
            throw ValidationError.passwordsDontMatch
        }
    }
    
    static func validatePhone(_ phone: String) throws {
        guard !phone.isEmpty else {
            throw ValidationError.emptyField("Phone number")
        }
        guard phone.range(of: Constants.Validation.phoneRegex, options: .regularExpression) != nil else {
            throw ValidationError.invalidPhoneNumber
        }
    }
} 
