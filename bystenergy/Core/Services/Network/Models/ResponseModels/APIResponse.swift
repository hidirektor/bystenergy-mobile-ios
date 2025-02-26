struct APIResponse<T: Decodable>: Decodable {
    let status: String
    let message: String?
    let data: T?
    let errors: [String]?
} 