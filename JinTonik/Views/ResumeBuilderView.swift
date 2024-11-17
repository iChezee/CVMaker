import SwiftUI

struct ResumeBuilderView: View {
    @EnvironmentObject var coordinator: MainCoordinatorStore
    @State var selectedCategory: MainCategory?
    @State var object: Resume
    
    let grid = [GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: grid) {
                ForEach(object.allFields, id: \.id) { field in
                    MainInfoCell(field: field)
                        .onTapGesture {
                            navigate(to: field.category)
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Resume builder")
                    .semibold(24)
                    .foregroundColor(.black)
            }
        }
    }
    
    var backButton: some View {
        Button {
            coordinator.routes.pop()
        } label: {
            Image(.backArrow)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
    
    func navigate(to category: MainCategory) {
        let flow: MainCoordinatorFlow
        switch category {
        case .profile:
            coordinator.navigateToProfile(object)
            return
        case .contact:
            flow = .contact(object)
        case .employment:
            flow = .employment(object)
        case .education:
            flow = .education(object)
        case .skills:
            flow = .skills(object)
        case .software:
            flow = .software(object)
        case .project:
            flow = .projects(object)
        case .language:
            flow = .languages(object)
        case .hobbie:
            flow = .hobbies(object)
        }
        
        coordinator.routes.push(flow)
    }
}
