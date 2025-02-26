import Foundation

class RequestManager {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
        self.encoder = JSONEncoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.api
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
    }
    
    func perform<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Encodable? = nil
    ) async throws -> T {
        guard NetworkMonitor.shared.isConnected else {
            throw APIError.noInternet
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaders = headers ?? Constants.API.defaultHeaders
        
        if let body = body {
            request.httpBody = try encoder.encode(body)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }
        case 401:
            throw APIError.unauthorized
        case 400:
            throw APIError.badRequest(try? decoder.decode(APIResponse<Never>.self, from: data))
        default:
            throw APIError.serverError(httpResponse.statusCode)
        }
    }
} 
