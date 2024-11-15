import SwiftUI

struct ResumeBuilderView: View {
    @EnvironmentObject var coordinator: MainCoordinatorStore
    @State var selectedCategory: MainCategory?
    let resume: Resume
    let grid = [GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: grid) {
                ForEach(resume.allFields) { field in
                    MainInfoCell(resumeField: field)
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
            coordinator.navigateToProfile(resume)
            return
        case .contact:
            flow = .contact(resume)
        case .employment:
            flow = .employment(resume)
        case .education:
            flow = .education(resume)
        case .skills:
            flow = .skills(resume)
        case .software:
            flow = .software(resume)
        case .project:
            flow = .projects(resume)
        case .language:
            flow = .languages(resume)
        case .hobbie:
            flow = .hobbies(resume)
        }
        
        coordinator.routes.push(flow)
    }
}

#Preview {
    let resume = Resume()
    NavigationView {
        ResumeBuilderView(resume: resume)
    }
}
