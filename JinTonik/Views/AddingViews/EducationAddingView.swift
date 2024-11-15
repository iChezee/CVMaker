import SwiftUI

struct EducationAddingView: View {
    @Environment(\.managedObjectContext) var context
    @State var object: MultilineTempObject
    
    init(_ object: MultilineObject?, list: ListMultilineObject) {
        if let object {
            self.object = MultilineTempObject(object, list: list)
        } else {
            self.object = MultilineTempObject(list)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AddingCustomNavBar(title: "Education")
                .padding(.top, 16)
                .padding(.horizontal, 10)
            ScrollView {
                VStack(spacing: 16) {
                    CommonTextField(title: "School", placeholder: "NY Institute of Technology", text: $object.title)
                    CommonTextField(title: "Specialisation / Degree", placeholder: "Engineering of Automation", text: $object.specialisation)
                    CommonTextField(title: "Location", placeholder: "New York, USA", text: $object.location)
                    CommonTextField(title: "Studying period", placeholder: "Sep. 2021 - April 2023", text: $object.period)
                    Toggle("Present", isOn: $object.present)
                        .padding(.horizontal, 8)
                    CommonTextEditor(title: "Description / Additional information", subtitle: "Please provide basic information about your field of study", text: $object.about)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)
            CommonAddButton(tempObject: object)
                .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden()
    }
}
