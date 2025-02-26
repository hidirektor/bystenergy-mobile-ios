import Foundation

extension Date {
    func formattedString(format: String = Constants.DateFormat.display) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = Constants.Validation.emailRegex
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        count >= Constants.Validation.minPasswordLength &&
        count <= Constants.Validation.maxPasswordLength
    }
}

extension URLRequest {
    var allHTTPHeaders: [String: String] {
        get { allHTTPHeaderFields ?? [:] }
        set { allHTTPHeaderFields = newValue }
    }
} 
