import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    case serverError(Int)
    case unauthorized
    case noInternet
    case badRequest(APIResponse<Never>?)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .unauthorized:
            return "Please log in again"
        case .noInternet:
            return "No internet connection"
        case .badRequest(let response):
            return response?.message ?? "Invalid request"
        case .unknown:
            return "An unknown error occurred"
        }
    }
} 
