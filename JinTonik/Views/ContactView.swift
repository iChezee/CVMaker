import SwiftUI

struct ContactView: View {
    @State var object: Contact
    
    init(_ resume: Resume) {
        self.object = resume.contact
    }
    
    var body: some View {
        VStack {
            CommonTextField(title: "Phone number", placeholder: "+ 1(256) 456 27 96", text: $object.telephone)
            CommonTextField(title: "Email", placeholder: "samgosling@gmail.com", text: $object.email)
            CommonTextField(title: "Profile URL", placeholder: "http://www.linkedin.com/in/samgosling", text: $object.profile)
            Spacer()
            NextButton(step: .employment(object.resume))
        }
        .padding(.horizontal, 20)
        .customNavBar(title: "Contacts")
    }
}
