import SwiftUI

struct MainView: View {
    @EnvironmentObject var coordinator: MainCoordinatorStore
    @Environment(\.managedObjectContext) var context
    @State var state: ViewState = .resumeList
    
    var body: some View {
        VStack {
            state.view
            controlView
                .padding(.horizontal, 44)
        }
        .background(.white)
        .navigationBarBackButtonHidden()
    }
    
    var controlView: some View {
        HStack {
            Button {
                withAnimation {
                    state = .resumeList
                }
            } label: {
                VStack(spacing: 2) {
                    Image(state == .resumeList ? .home : .homeUnselected)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Home")
                        .foregroundStyle(state == .resumeList ? .black : .subGrey)
                        .semibold(10)
                }
            }
            
            Spacer()
            
            Button {
                let newResume = Resume(context)
                context.insert(newResume)
                try? context.save()
                coordinator.navigateToBuilder(newResume)
            } label: {
                ZStack {
                    Color.accentYellow
                    Image(.addObject)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .frame(width: 50, height: 50)
                .clipShape(.circle)
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    state = .settingsView
                }
            } label: {
                VStack(spacing: 2) {
                    Image(state == .resumeList ? .settingsUnselected : .settings)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Settings")
                        .foregroundStyle(state == .resumeList ? .subGrey : .black)
                        .semibold(10)
                }
            }
        }
    }
}

extension MainView {
    enum ViewState {
        case resumeList
        case settingsView
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .resumeList:
                ResumeListView()
            case .settingsView:
                SettingsView()
            }
        }
    }
}

#Preview {
    NavigationView {
        MainView()
    }
}
