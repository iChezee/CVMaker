import SwiftUI

struct CommonAddButton: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    let tempObject: MultilineTempObject
    
    var body: some View {
        Button {
            if let cdObject = tempObject.existedObject {
                cdObject.updateFields(tempObject)
            } else {
                let object = MultilineObject(tempObject, context: context)
                context.insert(object)
            }
            try? context.save()
            dismiss()
        } label: {
            ZStack {
                Color.accentYellow
                Text("Add")
                    .foregroundStyle(.black)
                    .semibold(14)
            }
            .frame(height: 64)
            .clipShape(.capsule)
        }
    }
}

struct CommonSinglelineAddButton: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    let tempObject: SinglelineTempObject
    
    var body: some View {
        Button {
            if let cdObject = tempObject.existedObject {
                cdObject.updateFields(tempObject)
            } else {
                let object = SinglelineObject(tempObject, context: context)
                context.insert(object)
            }
            try? context.save()
            dismiss()
        } label: {
            ZStack {
                Color.accentYellow
                Text("Add")
                    .foregroundStyle(.black)
                    .semibold(14)
            }
            .frame(height: 64)
            .clipShape(.capsule)
        }
    }
}
