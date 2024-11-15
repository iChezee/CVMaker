import SwiftUI

struct EmploymentAddingView: View {
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
            AddingCustomNavBar(title: "Employment")
                .padding(.top, 16)
                .padding(.horizontal, 10)
            ScrollView {
                VStack(spacing: 16) {
                    CommonTextField(title: "Company", placeholder: "Netflix, Inc", text: $object.title)
                    CommonTextField(title: "Job title", placeholder: "QA engineer", text: $object.specialisation)
                    CommonTextField(title: "Location", placeholder: "New York, USA", text: $object.location)
                    CommonTextField(title: "Working period", placeholder: "Sep. 2021 - April 2023", text: $object.period)
                    Toggle("Present", isOn: $object.present)
                       .padding(.horizontal, 8)
                    CommonTextEditor(title: "Description / Additional information", subtitle: "Please provide basic information about your role", text: $object.about)
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
