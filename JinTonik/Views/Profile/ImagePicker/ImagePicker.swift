import SwiftUI

struct ImagePickerRepresentable: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    let completion: (Data?) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, completion: completion)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Environment(\.presentationMode) var presentationMode
        let parent: ImagePickerRepresentable
        let completion: (Data?) -> Void
        
        init(parent: ImagePickerRepresentable, completion: @escaping (Data?) -> Void) {
            self.parent = parent
            self.completion = completion
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                completion(uiImage.pngData())
            }
            parent.isShown = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }
}
