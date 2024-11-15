import SwiftUI

struct ResumeListView: View {
    @EnvironmentObject var container: PersistenceContainer
    @EnvironmentObject var coordinator: MainCoordinatorStore
    @Environment(\.managedObjectContext) var context
    @FetchRequest<Resume>(sortDescriptors: [NSSortDescriptor(keyPath: \Resume.timestamp, ascending: false)])
    var objects: FetchedResults<Resume>
    
    @State var newResume: Resume?
    
    @State var resumeToDelete: Resume?
    @State var deleteResumeAlert = false
    
    @State var editResume: Resume?
    @State var editResumeToogle = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("My resumes")
                .foregroundStyle(.black)
                .semibold(24)
                .padding()
            Spacer()
            if objects.isEmpty {
                emptyState
            } else {
                listOfObjects
            }
            Spacer()
        }
    }
    
    var emptyState: some View {
        VStack {
            EmptyStateView(title: "No CV History Yet")
            Button {
                let newResume = Resume(context)
                coordinator.navigateToBuilder(newResume)
            } label: {
                ZStack {
                    Color.accentYellow
                    Text("Create resume")
                        .foregroundStyle(.black)
                        .semibold(16)
                }
                .frame(height: 64)
            }
            .clipShape(.capsule)
        }
        .padding(.horizontal, 45)
    }
    
    var listOfObjects: some View {
        ScrollView {
            LazyVStack {
                ForEach(objects) { object in
                    cellFor(object)
                }
                .padding(.horizontal, 20)
            }
        }
        .alert("Are you sure?", isPresented: $deleteResumeAlert) {
            Button(role: .destructive) {
                withAnimation {
                    guard let object = resumeToDelete else {
                        deleteResumeAlert.toggle()
                        return
                    }
                    context.delete(object)
                    container.saveChanges()
                }
            } label: {
                Text("Yes")
            }
        } message: {
            Text("Are you sure want to delete this resume? This cannot be undone")
        }
    }
    
    func cellFor(_ object: Resume) -> some View {
        VStack(spacing: 24) {
            HStack(alignment: .top) {
                cellTitle(for: object)
                Spacer()
                Button {
                    coordinator.navigateToBuilder(object)
                } label: {
                    Image(.edit)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                Button {
                    resumeToDelete = object
                    deleteResumeAlert = true
                } label: {
                    Image(.delete)
                        .resizable()
                        .frame(width: 18, height: 18)
                }
            }
            
            Button {
                coordinator.navigateToBuilder(object)
            } label: {
                ZStack {
                    Color.accentYellow
                    Text("Continue creating")
                        .foregroundStyle(.black)
                        .semibold(16)
                }
                .frame(height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 100))
            }
        }
        .padding(20)
        .background(.mainGrey)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    @ViewBuilder
    func cellTitle(for object: Resume) -> some View {
        VStack {
            let name = object.profile.name
            if !name.isEmpty {
                Text(name)
                    .semibold(20)
                    .foregroundStyle(.black)
            }
            
            let jobTitle = object.profile.jobTitle
            if !jobTitle.isEmpty, name.isEmpty {
                Text(object.profile.jobTitle)
                    .semibold(20)
                    .foregroundStyle(.black)
            } else if !jobTitle.isEmpty, !name.isEmpty {
                Text(object.profile.jobTitle)
                    .semibold(16)
                    .foregroundStyle(.subGrey)
            }
            
            if name.isEmpty && jobTitle.isEmpty {
                Text("No name information")
                    .medium(16)
                    .foregroundStyle(.subGrey)
            }
        }
    }
}

#Preview {
    ResumeListView()
}
