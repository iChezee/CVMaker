import SwiftUI

struct SinglelineCellView: View {
    @EnvironmentObject var container: PersistenceContainer
    @Environment(\.managedObjectContext) var context
    let object: SinglelineObject
    let editObject: (SinglelineObject) -> Void
    @State var deleteObjectAlert = false
    
    init(_ object: SinglelineObject, editObject: @escaping (SinglelineObject) -> Void) {
        self.object = object
        self.editObject = editObject
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(object.name)
                    .regular(16)
                Spacer()
                buttonsStack
            }
            .padding(.leading, 30)
            .padding(.trailing, 10)
            HStack {
                ForEach(0..<5) { mark in
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(mark <= Int(object.mark) ?? 0 ? .accentYellow : .subGrey)
                    if mark < 4 {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 40)
        }
        .padding(.vertical, 20)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(.accentYellow)
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
        let object = SinglelineObject(context: context)
        object.name = "Some skill"
        object.mark = "3"
        try? context.save()
        return object
    }()
    
    SinglelineCellView(object) { _ in }
}
