import SwiftUI

final class JinSplashView: UIView { }

struct JinSplashViewRespresantable: UIViewRepresentable {
    func makeUIView(context: Context) -> JinSplashView {
        let view = Bundle.main.loadNibNamed(String(describing: SplashView.self), owner: nil)?.first as! JinSplashView
        return view
    }
    
    func updateUIView(_ uiViewController: JinSplashView, context: Context) { }
}

struct SplashView: View {
    @State var goNext: Bool?
    
    var body: some View {
        mainView
            .task {
                do {
                    try await Task.sleep(nanoseconds: 5)
                    await MainActor.run {
                        withAnimation {
                            goNext = true
                        }
                    }
                } catch {
                    
                }
            }
    }
    
    var mainView: some View {
        ZStack {
            JinSplashViewRespresantable()
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(.circular)
                .foregroundStyle(.black)
                .padding(.top, 150)
                .scaleEffect(1.5)
        }
    }
}

#Preview {
    SplashView()
}
