import SwiftUI
import BrightroomUI
import BrightroomEngine

struct CropView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var editingStack: EditingStack
    let completion: (Data?) -> Void
    
    init(resultImage: Data?, completion: @escaping (Data?) -> Void) throws {
        let provider = try ImageProvider(data: resultImage!)
        let stack = EditingStack(imageProvider: provider)
        self._editingStack = StateObject(wrappedValue: stack)
        self.completion = completion
    }
    
    var body: some View {
        SwiftUIPhotosCropView(editingStack: editingStack) {
            completion(try? editingStack.makeRenderer().render().uiImage.pngData())
            dismiss()
        } onCancel: {
            dismiss()
        }
        .ignoresSafeArea()
        .onAppear {
            editingStack.start()
        }
    }
    
}
