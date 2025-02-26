import Foundation

class Debouncer {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func debounce(action: @escaping () -> Void) {
        workItem?.cancel()
        
        let workItem = DispatchWorkItem(block: action)
        self.workItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
    }
    
    func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}

// Usage example:
class SearchViewModel: ObservableObject {
    private let debouncer = Debouncer(delay: 0.5)
    
    func performSearch(query: String) {
        debouncer.debounce { [weak self] in
            self?.executeSearch(query)
        }
    }
    
    private func executeSearch(_ query: String) {
        // Actual search implementation
    }
} 
