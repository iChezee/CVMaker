import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .foregroundStyle(.black)
                .semibold(24)
                .padding()
            Spacer()
            Color.white
        }
        .background(.white)
    }
}

#Preview {
    SettingsView()
}
