import Foundation

struct DashboardResponse: Decodable {
    let user: AppUser
    let statusCards: [StatusCardData]
} 
