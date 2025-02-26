import Foundation
import CryptoKit

enum SecureStorageError: Error {
    case encryptionFailed
    case decryptionFailed
    case keyGenerationFailed
    case dataCorrupted
    case invalidKey
}

final class SecureStorageManager {
    static let shared = SecureStorageManager()
    
    private let keychain = KeychainManager.shared
    private let keychainKeyTag = "com.bystenergy.encryption.key"
    private let symmetricKeySize = SymmetricKeySize.bits256
    
    private var symmetricKey: SymmetricKey?
    
    private init() {
        do {
            try loadOrGenerateKey()
        } catch {
            print("Failed to initialize SecureStorageManager: \(error)")
        }
    }
    
    // MARK: - Public Methods
    
    func encrypt(_ data: Data) throws -> Data {
        guard let key = symmetricKey else {
            throw SecureStorageError.invalidKey
        }
        
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined ?? Data()
        } catch {
            throw SecureStorageError.encryptionFailed
        }
    }
    
    func decrypt(_ encryptedData: Data) throws -> Data {
        guard let key = symmetricKey else {
            throw SecureStorageError.invalidKey
        }
        
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            return try AES.GCM.open(sealedBox, using: key)
        } catch {
            throw SecureStorageError.decryptionFailed
        }
    }
    
    func secureStore(_ data: Data, forKey key: String) throws {
        let encryptedData = try encrypt(data)
        try keychain.save(encryptedData, service: Constants.Storage.keychainService, account: key)
    }
    
    func secureRetrieve(forKey key: String) throws -> Data {
        let encryptedData = try keychain.retrieve(service: Constants.Storage.keychainService, account: key)
        return try decrypt(encryptedData)
    }
    
    func secureDelete(forKey key: String) throws {
        try keychain.delete(service: Constants.Storage.keychainService, account: key)
    }
    
    // MARK: - Convenience Methods
    
    func secureStore<T: Encodable>(_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        try secureStore(data, forKey: key)
    }
    
    func secureRetrieve<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T {
        let data = try secureRetrieve(forKey: key)
        return try JSONDecoder().decode(type, from: data)
    }
    
    // MARK: - Private Methods
    
    private func loadOrGenerateKey() throws {
        if let existingKey = try? loadExistingKey() {
            symmetricKey = existingKey
        } else {
            try generateAndStoreNewKey()
        }
    }
    
    private func loadExistingKey() throws -> SymmetricKey? {
        guard let keyData = try? keychain.retrieve(
            service: Constants.Storage.keychainService,
            account: keychainKeyTag
        ) else {
            return nil
        }
        
        return SymmetricKey(data: keyData)
    }
    
    private func generateAndStoreNewKey() throws {
        let newKey = SymmetricKey(size: symmetricKeySize)
        let keyData = newKey.withUnsafeBytes { Data($0) }
        
        try keychain.save(
            keyData,
            service: Constants.Storage.keychainService,
            account: keychainKeyTag
        )
        
        symmetricKey = newKey
    }
}

// MARK: - Usage Examples

extension SecureStorageManager {
    // Example of storing sensitive user data
    func storeSensitiveUserData(_ userData: SensitiveUserData) throws {
        try secureStore(userData, forKey: "sensitive_user_data")
    }
    
    // Example of retrieving sensitive user data
    func retrieveSensitiveUserData() throws -> SensitiveUserData {
        try secureRetrieve(SensitiveUserData.self, forKey: "sensitive_user_data")
    }
}

// Example of sensitive data structure
struct SensitiveUserData: Codable {
    let socialSecurityNumber: String
    let creditCardNumber: String
    let bankAccountDetails: BankAccountDetails
    
    struct BankAccountDetails: Codable {
        let accountNumber: String
        let routingNumber: String
        let bankName: String
    }
} 
