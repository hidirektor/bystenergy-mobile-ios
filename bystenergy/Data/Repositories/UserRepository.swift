import Foundation

protocol UserRepositoryProtocol {
    func getCurrentUser() async throws -> AppUser
    func updateUser(_ request: AppUser.UpdateRequest) async throws -> AppUser
    func updatePreferences(_ preferences: AppUser.UserPreferences) async throws
    func deleteAccount() async throws
}

final class UserRepository: UserRepositoryProtocol {
    private let apiManager: APIManager
    private let secureStorage: SecureStorageManager
    
    init(
        apiManager: APIManager = .shared,
        secureStorage: SecureStorageManager = .shared
    ) {
        self.apiManager = apiManager
        self.secureStorage = secureStorage
    }
    
    func getCurrentUser() async throws -> AppUser {
        try await apiManager.request(.userProfile)
    }
    
    func updateUser(_ request: AppUser.UpdateRequest) async throws -> AppUser {
        try await apiManager.request(.updateProfile(request))
    }
    
    func updatePreferences(_ preferences: AppUser.UserPreferences) async throws {
        let request = AppUser.UpdateRequest(
            fullName: nil,
            phoneNumber: nil,
            preferences: preferences
        )
        _ = try await updateUser(request)
    }
    
    func deleteAccount() async throws {
        _ = try await apiManager.request(.deleteAccount) as EmptyResponse
        try secureStorage.secureDelete(forKey: "auth_token")
    }
}

struct EmptyResponse: Decodable {} 
