import Foundation

public struct StatusCardData: Identifiable, Decodable {
    public let id: UUID
    public let title: String
    public let value: String
    public let trend: Double
    public let icon: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case value
        case trend
        case icon
    }
    
    public init(
        id: UUID = UUID(),
        title: String,
        value: String,
        trend: Double,
        icon: String
    ) {
        self.id = id
        self.title = title
        self.value = value
        self.trend = trend
        self.icon = icon
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.value = try container.decode(String.self, forKey: .value)
        self.trend = try container.decode(Double.self, forKey: .trend)
        self.icon = try container.decode(String.self, forKey: .icon)
    }
} 
