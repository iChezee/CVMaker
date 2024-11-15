import SwiftUI

struct CommonTextEditor: View {
    let title: String
    let subtitle: String
    @Binding var text: String
    @FocusState var textEditing
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .medium(16)
                .foregroundStyle(.black)
                .padding(.leading, 8)
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .focused($textEditing)
                    .padding(8)
                    .scrollContentBackground(.hidden)
                    .background(.mainGrey)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(minHeight: 100)
                    
                if text.isEmpty && !textEditing {
                    Text(subtitle)
                        .foregroundStyle(.subGrey)
                        .padding()
                        .onTapGesture {
                            textEditing.toggle()
                        }
                }
            }
            .regular(16)
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    VStack {
        CommonTextEditor(title: "Some text", subtitle: "Please provide info", text: .constant(""))
        CommonTextEditor(title: "Some text", subtitle: "Please provide info", text: .constant("Please provide info"))
    }
}
