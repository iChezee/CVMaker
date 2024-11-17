import SwiftUI
import FlowStacks

enum MainCoordinatorFlow: Equatable {
    case splash
    case main
    case resumeBuilder(Resume)
    case profile(Resume)
    case contact(Resume)
    case employment(Resume)
    case education(Resume)
    case skills(Resume)
    case software(Resume)
    case languages(Resume)
    case projects(Resume)
    case hobbies(Resume)
    case chooseTemplate(Resume)
    case resultResume(Resume)
    case crop(Data?, (Data?) -> Void)
    case camera((Data?) -> Void)
    
    var id: Int {
        switch self {
        case .splash: 0
        case .main: 1
        case .resumeBuilder: 2
        case .profile, .contact, .employment, .education, .skills, .software, .languages, .projects, .hobbies: 3
        case .crop, .camera: 4
        case .chooseTemplate: 5
        case .resultResume: 6
        }
    }
    
    static func ==(lhs: MainCoordinatorFlow, rhs: MainCoordinatorFlow) -> Bool {
        lhs.id == rhs.id
    }
}

final class MainCoordinatorStore: ObservableObject {
    static let shared = MainCoordinatorStore()
    
    @Published var routes: Routes<MainCoordinatorFlow>
    
    init() {
        #if DEBUG
        self.routes = [.root(.main, embedInNavigationView: true)]
        #else
        self.routes = [.root(.splash, withNavigation: true)]
        #endif
    }
    
    func navigateToBuilder(_ object: Resume) {
        routes.push(.resumeBuilder(object))
    }
    
    func popToBuilder() {
        routes.popTo { value in
            value.id == 2
        }
    }
    
    func navigateToProfile(_ object: Resume) {
        routes.push(.profile(object))
    }
    
    func presentCamera(_ completion: @escaping (Data?) -> Void) {
        routes.presentCover(.camera(completion))
    }
    
    func presentCrop(_ imageData: Data?, completion: @escaping (Data?) -> Void) {
        routes.presentCover(.crop(imageData, completion))
    }
}

struct MainCoordinator: View {
    @StateObject var navigationStore = MainCoordinatorStore.shared
    
    var body: some View {
        Router($navigationStore.routes) { screen in
            switch screen {
            case .main: MainView()
            case .resumeBuilder(let resume): ResumeBuilderView(object: resume)
            case .profile(let object): ProfileView(object)
            case .contact(let object): ContactView(object)
            case .employment(let object): MultilineObjectsView("Employment", list: object.employment, nextStep: .education(object)) { additionObject in
                EmploymentAddingView(additionObject, list: object.employment)
            }
            case .education(let object): MultilineObjectsView("Education", list: object.education, nextStep: .skills(object)) { additionObject in
                EducationAddingView(additionObject, list: object.education)
            }
            case .skills(let object): SinglelineObjectsView("Skills", list: object.skills, nextStep: .software(object)) { additionObject in
                SinglelineAddingView("Skill", placeholder: "Skill name", list: object.skills)
            }
            case .software(let object): SinglelineObjectsView("Software", list: object.software, nextStep: .languages(object)) { additionObject in
                SinglelineAddingView("Software", placeholder: "Software name", list: object.skills)
            }
            case .languages(let object): SinglelineObjectsView("Languages", list: object.skills, nextStep: .projects(object)) { additionObject in
                SinglelineAddingView("Languages", placeholder: "Languages name", list: object.skills)
            }
            case .projects(let object): MultilineObjectsView("Projects", list: object.education, nextStep: .hobbies(object)) { additionObject in
                ProjectsAddingView(additionObject, list: object.project)
            }
            case .hobbies(let object): HobbiesListView(object.hobbies)
            case .crop(let data, let completion): try? CropView(resultImage: data, completion: completion)
            case .camera(let completion): CameraView(completion: completion)
            default: EmptyView()
            }
        }
        .environmentObject(navigationStore)
    }
}

