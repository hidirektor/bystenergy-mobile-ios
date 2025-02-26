import Foundation

final class APIManager {
    static let shared = APIManager()
    private let requestManager: RequestManager
    
    private init() {
        self.requestManager = RequestManager()
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = buildURL(for: endpoint) else {
            throw APIError.invalidURL
        }
        
        var headers = Constants.API.defaultHeaders
        
        // Add auth token if available
        if let token = try? KeychainManager.shared.retrieve(service: "auth", account: "token") {
            headers["Authorization"] = "Bearer \(String(data: token, encoding: .utf8) ?? "")"
        }
        
        return try await requestManager.perform(
            url: url,
            method: endpoint.method,
            headers: headers,
            body: endpoint.body
        )
    }
    
    private func buildURL(for endpoint: Endpoint) -> URL? {
        var components = URLComponents(string: AppConfiguration.shared.baseURL)
        components?.path = "/\(AppConfiguration.shared.apiVersion)/\(endpoint.path)"
        
        if let queryItems = endpoint.queryItems {
            components?.queryItems = queryItems
        }
        
        return components?.url
    }
    
    // Convenience methods for common operations
    func get<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        try await request(endpoint)
    }
    
    func post<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        try await request(endpoint)
    }
    
    func put<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        try await request(endpoint)
    }
    
    func delete<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        try await request(endpoint)
    }
} 
