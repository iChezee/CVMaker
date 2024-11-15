import SwiftUI

struct SinglelineAddingView: View {
    let title: String
    let placeholder: String
    
    @State var object: SinglelineTempObject
    
    init(_ title: String, placeholder: String, object: SinglelineObject? = nil, list: ListSinglelineObject) {
        self.title = title
        self.placeholder = placeholder
        
        if let object {
            self.object = SinglelineTempObject(object, list: list)
        } else {
            self.object = SinglelineTempObject(list)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AddingCustomNavBar(title: title)
                .padding(.top, 32)
                .padding(.horizontal, 16)
            Group {
                addingView
                CommonSinglelineAddButton(tempObject: object)
            }
            .padding(.horizontal, 16)
        }
    }
    
    var addingView: some View {
        VStack {
            Group {
                TextField(placeholder, text: $object.name)
                    .regular(16)
                    .foregroundStyle(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .background(.white)
                HStack {
                    ForEach(0..<5, id: \.self) { mark in
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(mark <= Int(object.mark) ?? 0 ? .accentYellow : .subGrey)
                            .onTapGesture {
                                withAnimation {
                                    object.mark = "\(mark)"
                                }
                            }
                        if mark < 4 {
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
                .background(.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(12)
        .background(.subGrey)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
