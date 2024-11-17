import SwiftUI

struct SinglelineObjectsView<AddingView: View>: View {
    @EnvironmentObject var store: MainCoordinatorStore
    @Environment(\.managedObjectContext) var context
    
    @State var presentAdditionSheet = false
    @State var editingObject: SinglelineObject?
    
    var fetchRequest: FetchRequest<SinglelineObject>
    var objects: FetchedResults<SinglelineObject> {
        fetchRequest.wrappedValue
    }
    
    let title: String
    let nextStep: MainCoordinatorFlow
    let additionView: (SinglelineObject?) -> AddingView
    
    init(_ title: String, list: ListSinglelineObject, nextStep: MainCoordinatorFlow, additionView: @escaping (SinglelineObject?) -> AddingView) {
        self.title = title
        self.nextStep = nextStep
        self.additionView = additionView
        
        fetchRequest = FetchRequest<SinglelineObject>(entity: SinglelineObject.entity(),
                                                     sortDescriptors: [NSSortDescriptor(keyPath: \SinglelineObject.timestamp, ascending: false)],
                                                     predicate: NSPredicate(format: "%K == %@", #keyPath(SinglelineObject.list), list))
    }
    
    var body: some View {
        VStack {
            mainView
            addMoreButton
            NextButton(step: nextStep)
        }
        .padding([.top, .horizontal], 20)
        .customNavBar(title: title)
        .sheet(isPresented: $presentAdditionSheet) {
            additionView(editingObject)
                .presentationCornerRadius(32)
                .presentationDetents([.height(250)])
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
                    ForEach(objects) { object in
                        SinglelineCellView(object) { editObject in
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
}
