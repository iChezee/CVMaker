import SwiftUI

struct ImageSourceChoose: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedSource: SourceChoose?
    var body: some View {
        VStack {
            HStack {
                Text("Profile image")
                    .semibold(20)
                    .padding(.top, 32)
                Spacer()
                closeButton
                    .padding(.top, 16)
            }
            Spacer()
            buttonsStack
                .padding(.bottom, 30)
        }
        .padding(.horizontal, 16)
    }
    
    var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(.crossGrey)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
    
    var buttonsStack: some View {
        HStack {
            ForEach(SourceChoose.allCases, id:\.rawValue) { value in
                value.view
                    .onTapGesture {
                        selectedSource = value
                    }
            }
        }
    }
}

extension ImageSourceChoose {
    enum SourceChoose: Int, CaseIterable {
        case gallery
        case camera
        
        var image: some View {
            switch self {
            case .gallery: Image(.gallery).resizable()
            case .camera: Image(.camera).resizable()
            }
        }
        
        var title: String {
            switch self {
            case .gallery: "Gallery"
            case .camera: "Camera"
            }
        }
        
        var view: some View {
            ZStack {
                Color.mainGrey
                VStack {
                    ZStack {
                        Color.accentYellow
                            .clipShape(.circle)
                        image
                            .frame(width: 32, height: 32)
                    }
                    .frame(width: 52, height: 52)
                    Text(title)
                        .medium(16)
                        .foregroundStyle(.black)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
