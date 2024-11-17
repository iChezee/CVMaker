import SwiftUI

struct HobbieListCell: View {
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
        VStack(alignment: .leading) {
            HStack {
                Ellipse()
                    .foregroundStyle(.accentYellow)
                    .frame(width: 10, height: 10)
                Text(object.name)
                    .medium(16)
                Spacer()
                buttonsStack
            }
            Text(object.mark)
                .regular(14)
                .padding(.leading, 18)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
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
