import SwiftUI
import AVFoundation

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var model: CameraDataModel
    @State var showLanguageSelectSheet = false
 
    private static let barHeightFactor = 0.15
    
    var flashImage: Image {
        switch model.camera.flashMode {
        case .auto:
            return Image(systemName: "bolt")
        case .on:
            return Image(systemName: "bolt.fill")
        case .off:
            return Image(systemName: "bolt.slash")
        @unknown default:
            return Image(systemName: "bolt.slash")
        }
    }
    
    init(completion: @escaping (Data?) -> Void) {
        _model = StateObject(wrappedValue: CameraDataModel(completion: completion))
    }
    
    var body: some View {
            GeometryReader { geometry in
                ViewfinderView(image:  $model.viewfinderImage)
                    .overlay(alignment: .top) {
                        topButtonsView
                    }
                    .overlay(alignment: .bottom) {
                        buttonsView()
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                            .background(.black.opacity(0.75))
                    }
                    .overlay(alignment: .center)  {
                        Color.clear
                            .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                            .accessibilityElement()
                            .accessibilityLabel("View Finder")
                            .accessibilityAddTraits([.isImage])
                    }
                    .background(.black)
            }
            .task {
                await model.camera.start()
            }
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
    }
    
    private var topButtonsView: some View {
        HStack {
            Button {
                goBack()
            } label: {
                ZStack {
                    Color.black.opacity(0.8)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("X")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            Spacer()
            Spacer()
            Button {
                model.camera.flashMode = {
                    switch model.camera.flashMode {
                    case .auto:
                        return AVCaptureDevice.FlashMode.on
                    case .on:
                        return AVCaptureDevice.FlashMode.off
                    case .off:
                        return AVCaptureDevice.FlashMode.auto
                    @unknown default:
                        return .auto
                    }
                }()
            } label: {
                ZStack {
                    Color.black.opacity(0.8)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    flashImage
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
    }
    
    private func buttonsView() -> some View {
        HStack(spacing: 60) {
            Spacer()
            Color.clear
                .frame(width: 50, height: 50)
            
            Button {
                model.camera.takePhoto()
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 3)
                            .frame(width: 62, height: 62)
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                    }
                }
            }
            
            Button {
                model.camera.switchCaptureDevice()
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white)
            }
            
            Spacer()
        
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
    
    func goBack() {
        model.camera.stop() {
            Task {
                await MainActor.run {
                    model.viewfinderImage = nil
                    dismiss()
                }
            }
        }
    }
}
