import SwiftUI

struct SettingsView: View {
    @ObservedObject private var viewModel: SettingsViewModel
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            Section {
                UserProfileHeader(user: viewModel.user)
            }
            
            Section("Preferences") {
                ForEach(viewModel.preferences) { preference in
                    SettingsRow(item: preference)
                }
            }
            
            Section {
                Button("Sign Out", role: .destructive) {
                    viewModel.signOut()
                    appCoordinator.navigate(to: .auth(.login))
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppCoordinator())
} 
