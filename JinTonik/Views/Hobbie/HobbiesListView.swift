import SwiftUI

struct HobbiesListView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var store: MainCoordinatorStore
    
    @State var editingObject: SinglelineObject?
    @State var presentAdditionSheet = false
    
    var fetchRequest = FetchRequest<SinglelineObject>(entity: SinglelineObject.entity(), sortDescriptors: [])
    var objects: FetchedResults<SinglelineObject> {
        fetchRequest.wrappedValue
    }
    
    let list: ListSinglelineObject
    
    init(_ list: ListSinglelineObject) {
        self.list = list
        fetchRequest = FetchRequest<SinglelineObject>(entity: SinglelineObject.entity(),
                                                      sortDescriptors: [NSSortDescriptor(keyPath: \SinglelineObject.timestamp, ascending: false)],
                                                      predicate: NSPredicate(format: "%K == %@", #keyPath(SinglelineObject.list), list))
    }
    
    var body: some View {
        VStack {
            mainView
            addMoreButton
            chooseTemplateButton
        }
        .padding([.top, .horizontal], 20)
        .customNavBar(title: "Hobbies")
        .sheet(isPresented: $presentAdditionSheet) {
            HobbiesAdditionView(object: editingObject, list: list)
                .presentationCornerRadius(32)
        }
    }
    
    @ViewBuilder
    var mainView: some View {
        if objects.isEmpty {
            Spacer()
            EmptyStateView(title: "It's empty here for now.")
            Spacer()
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(objects, id: \.id) { object in
                        HobbieListCell(object) { editObject in
                            self.editingObject = editObject
                            self.presentAdditionSheet = true
                        }
                    }
                }
            }
        }
    }
    
    var addMoreButton: some View {
        Button {
            editingObject = nil
            presentAdditionSheet = true
        } label: {
            ZStack {
                Color.white
                HStack {
                    Image(.addObject)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Add more")
                        .semibold(14)
                        .foregroundStyle(.black)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 100)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.accentYellow)
            }
        }
        .frame(height: 64)
    }
    
    var chooseTemplateButton: some View {
        Button {
            
        } label: {
            ZStack {
                Color.accentYellow
                HStack {
                    Color.clear.frame(width: 48, height: 1)
                    Spacer()
                    Text("Choose template")
                        .semibold(14)
                        .foregroundStyle(.black)
                    Spacer()
                    ZStack {
                        Color.black
                        Image(.chooseNextArrow)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 48, height: 24)
                    .clipShape(.circle)
                }
                .padding(.horizontal, 8)
            }
            .frame(height: 64)
            .clipShape(.capsule)
        }
    }
}
