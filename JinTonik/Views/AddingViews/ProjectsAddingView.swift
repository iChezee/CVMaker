import SwiftUI

struct ProjectsAddingView: View {
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
            AddingCustomNavBar(title: "Projects")
                .padding(.top, 16)
                .padding(.horizontal, 10)
            ScrollView {
                VStack(spacing: 16) {
                    CommonTextField(title: "Project name", placeholder: "Digital advertising", text: $object.title)
                    CommonTextField(title: "Project URL", placeholder: "http://digitaladd.tomorrow", text: $object.specialisation)
                    CommonTextField(title: "Location", placeholder: "New York, USA", text: $object.location)
                    CommonTextField(title: "Period", placeholder: "Sep. 2021 - April 2023", text: $object.period)
                    Toggle("Present", isOn: $object.present)
                        .padding(.horizontal, 8)
                    CommonTextEditor(title: "Description / Additional information", subtitle: "Please provide basic project description", text: $object.about)
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
