import SwiftUI

struct HobbiesAdditionView: View {
    @State var object: SinglelineTempObject
    
    init(object: SinglelineObject? = nil, list: ListSinglelineObject) {
        if let object {
            self.object = SinglelineTempObject(object, list: list)
        } else {
            self.object = SinglelineTempObject(list)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AddingCustomNavBar(title: "Employment")
                .padding(.top, 16)
                .padding(.horizontal, 10)
            VStack(spacing: 16) {
                CommonTextField(title: "Hobbie", placeholder: "Photography", text: $object.name)
                CommonTextEditor(title: "Description / Additional information", subtitle: "Please provide basic information", text: $object.mark)
            }
            .padding(.horizontal, 16)
            Spacer()
            CommonSinglelineAddButton(tempObject: object)
                .padding(.horizontal, 16)
        }
    }
}
