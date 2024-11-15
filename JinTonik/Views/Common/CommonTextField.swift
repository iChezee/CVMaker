import SwiftUI

struct CommonTextField: View {
    @State var title: String
    @State var placeholder: String
    @Binding var text: String
    @FocusState var isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .medium(16)
                .padding(.leading, 8)
            HStack {
                TextField(placeholder, text: $text)
                    .regular(16)
                    .focused($isEditing)
                if !isEditing && !text.isEmpty {
                    Button {
                        withAnimation {
                            text = ""
                        }
                    } label: {
                        Image(.crossGrey)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(.mainGrey)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    CommonTextField(title: "Phone number", placeholder: "+ 1(256) 456 27 96", text: .constant(""))
}
