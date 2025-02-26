import SwiftUI

struct StatusCard: View {
    let data: StatusCardData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: data.icon)
                    .foregroundColor(.appPrimary)
                Text(data.title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(data.value)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                Image(systemName: data.trend >= 0 ? "arrow.up.right" : "arrow.down.right")
                Text("\(abs(data.trend), specifier: "%.1f")%")
                    .font(.caption)
                    .foregroundColor(data.trend >= 0 ? .green : .red)
            }
        }
        .padding()
        .cardStyle()
    }
}

#Preview {
    StatusCard(data: StatusCardData(
        title: "Energy Usage",
        value: "450 kWh",
        trend: 5.2,
        icon: "bolt.fill"
    ))
} 