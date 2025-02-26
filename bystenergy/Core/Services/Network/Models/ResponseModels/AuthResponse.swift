import Foundation

struct AuthResponse: Decodable {
    let token: String
    let user: AppUser
}

struct User: Codable {
    let id: String
    let email: String
    let fullName: String
    let phoneNumber: String?
    let createdAt: Date
} 
