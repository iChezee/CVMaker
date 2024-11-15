import SwiftUI

struct AddingCustomNavBar: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .semibold(20)
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(.crossGrey)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}
