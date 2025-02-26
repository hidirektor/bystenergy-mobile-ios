import Network
import Combine
import Foundation

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor
    @Published private(set) var isConnected: Bool = true
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                NotificationCenter.default.post(name: .networkStatusChanged, object: nil)
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
} 
