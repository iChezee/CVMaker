import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var container: PersistenceContainer
    @EnvironmentObject var navigationStore: MainCoordinatorStore
    @Environment(\.managedObjectContext) var context
    @State var object: Profile
    @State var presentPhotoSourceChoose = false
    @State var selectedSource: ImageSourceChoose.SourceChoose?
    @State var openPickFromGallery = false
    @State var openPickFromCamera = false
    
    init(_ resume: Resume) {
        object = resume.profile
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                imagePicker
                Text("Please provide basic information about yourself")
                    .medium(15)
                    .frame(maxWidth: .infinity)
            }
            CommonTextField(title: "Name", placeholder: "Sam Gosling", text: $object.name)
            CommonTextField(title: "Job title", placeholder: "QA Engineer", text: $object.jobTitle)
            CommonTextField(title: "Location", placeholder: "New York, USA", text: $object.location)
            CommonTextEditor(title: "About me", subtitle: "", text: $object.about)
            Spacer()
            NextButton(step: .contact(object.resume))
        }
        .padding(.horizontal, 20)
        .foregroundStyle(.black)
        .customNavBar(title: "Profile")
        .onChange(of: selectedSource) {
            presentPhotoSourceChoose = false
            if selectedSource == .camera {
                takePicFromCameraFlow()
            } else if selectedSource == .gallery {
                openPickFromGallery.toggle()
            }
        }
        .sheet(isPresented: $presentPhotoSourceChoose) {
            ImageSourceChoose(selectedSource: $selectedSource)
                .presentationDetents([.height(250)])
                .presentationCornerRadius(32)
        }
        .sheet(isPresented: $openPickFromGallery) {
            ImagePickerRepresentable(isShown: $openPickFromGallery) { data in
                if let data {
                    navigationStore.presentCrop(data) { data in
                        object.imageData = data
                        
                    }
                }
            }
            .ignoresSafeArea()
        }
        .onDisappear {
            container.saveChanges()
        }
    }
    
    var imagePicker: some View {
        Button {
            presentPhotoSourceChoose.toggle()
        } label: {
            if let imageData = object.imageData,
               let uiimage = UIImage(data: imageData) {
                Image(uiImage: uiimage)
                    .resizable()
            } else {
                ZStack {
                    Color.mainGrey
                    VStack {
                        Image(.profile)
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("Add photo")
                            .medium(12)
                    }
                }
            }
        }
        .frame(width: 82, height: 82)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func takePicFromCameraFlow() {
        navigationStore.presentCamera { data in
            navigationStore.routes.dismiss()
            if let data {
                navigationStore.presentCrop(data) { data in
                    object.imageData = data
                }
            }
        }
    }
}
