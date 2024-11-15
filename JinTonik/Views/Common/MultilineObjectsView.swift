import SwiftUI
import CoreData

struct MultilineObjectsView<AddingView: View>: View {
    @EnvironmentObject var store: MainCoordinatorStore
    @Environment(\.managedObjectContext) var context
    let nextStep: MainCoordinatorFlow
    let additionView: (MultilineObject?) -> AddingView
    @FetchRequest<MultilineObject>(sortDescriptors: [])
    var objects: FetchedResults<MultilineObject>
    @State var presentAdditionSheet = false
    @State var editingObject: MultilineObject?
    let list: ListMultilineObject
    let title: String
    
    init(_ title: String, list: ListMultilineObject, nextStep: MainCoordinatorFlow, additionView: @escaping (MultilineObject?) -> AddingView) {
        self.title = title
        self.list = list
        self.nextStep = nextStep
        self.additionView = additionView
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
        }
        .onAppear {
            _objects.wrappedValue.nsPredicate = NSPredicate(format: "list == %@", list)
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
                        MultilineCellView(object) { editObject in
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
