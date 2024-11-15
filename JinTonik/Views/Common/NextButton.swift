import SwiftUI

struct NextButton: View {
    @EnvironmentObject var store: MainCoordinatorStore
    let step: MainCoordinatorFlow
    
    var body: some View {
        Button {
            store.routes.push(step)
        } label: {
            ZStack {
                Color.accentYellow
                Text("Next")
                    .foregroundStyle(.black)
                    .semibold(14)
            }
            .frame(height: 64)
            .clipShape(.capsule)
        }
    }
}
