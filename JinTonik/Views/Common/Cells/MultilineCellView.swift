import SwiftUI

struct MultilineCellView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var container: PersistenceContainer
    let object: MultilineObject
    let editObject: (MultilineObject) -> Void
    @State var deleteObjectAlert = false
    
    init(_ object: MultilineObject, editObject: @escaping (MultilineObject) -> Void) {
        self.object = object
        self.editObject = editObject
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Ellipse()
                    .foregroundStyle(.accentYellow)
                    .frame(width: 10, height: 10)
                let specialisation = object.specialisation.isEmpty ? "QA engineer" : object.specialisation
                Text(specialisation)
                    .medium(16)
                Spacer()
                buttonsStack
            }
            textStack
                .padding(.leading, 18)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(.accentYellow)
        }
        .alert("Are you sure?", isPresented: $deleteObjectAlert) {
            Button(role: .destructive) {
                withAnimation {
                    context.delete(object)
                    container.saveChanges()
                }
            } label: {
                Text("Yes")
            }
        } message: {
            Text("Are you sure want to delete this note? This cannot be undone")
        }
    }
    
    var textStack: some View {
        VStack(alignment: .leading) {
            Group {
                let title = object.title.isEmpty ? "Netflix, Inc" : object.title
                Text(title)
                let period = object.period.isEmpty ? "Sep. 2021 - Till now" :
                object.period
                Text(period)
                let about = object.about.isEmpty ? "Description / Additional information" : object.about
                Text(about)
                    .lineLimit(1)
            }
            .regular(16)
        }
        .foregroundStyle(.black)
    }
    
    var buttonsStack: some View {
        HStack {
            Group {
                Button {
                    editObject(object)
                } label: {
                    Image(.edit)
                        .resizable()
                }
                
                Button {
                    deleteObjectAlert.toggle()
                } label: {
                    Image(.delete)
                        .resizable()
                }
            }
            .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    let context = PersistenceContainer(inMemory: true).viewContext
    let object = {
        let employment = MultilineObject(context: context)
        employment.title = "Netflix, Inc"
        employment.specialisation = "QA Engineer"
        employment.period = "Sep. 2021 - Till now"
        employment.about = "Description for some few words and another few words"
        try? context.save()
        return employment
    }()
    MultilineCellView(object) { _ in }
}
