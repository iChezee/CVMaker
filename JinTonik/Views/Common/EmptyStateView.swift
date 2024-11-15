import SwiftUI

struct EmptyStateView: View {
    let title: String
    
    var body: some View {
        VStack {
            Image(.worker)
            Text(title)
                .foregroundStyle(.black)
                .semibold(24)
                .padding(.top, 24)
            Text("Start building your professional journey now.")
                .foregroundStyle(.subGrey)
                .regular(16)
                .multilineTextAlignment(.center)
        }
    }
}
