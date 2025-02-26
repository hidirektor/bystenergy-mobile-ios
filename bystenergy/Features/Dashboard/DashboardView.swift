import SwiftUI

struct DashboardView: View {
    @ObservedObject private var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel? = nil) {
        self.viewModel = viewModel ?? DashboardViewModel()
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                DashboardHeader(user: viewModel.user)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(viewModel.statusCards) { card in
                        StatusCard(data: card)
                    }
                }
                
                // Additional dashboard content...
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .refreshable {
            await viewModel.fetchDashboardData()
        }
        .task {
            await viewModel.fetchDashboardData()
        }
    }
}

#Preview {
    DashboardView()
} 
