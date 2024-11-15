import SwiftUI

struct CustomizedNavigationBar: ViewModifier {
    @EnvironmentObject var coordinator: MainCoordinatorStore
    let title: String
    let dismissCompletion: (() -> Void)?
    
    init(title: String, dismissCompletion: (() -> Void)? = nil) {
        self.title = title
        self.dismissCompletion = dismissCompletion
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: backButton)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .semibold(24)
                        .foregroundColor(.black)
                }
            }
    }
    
    var backButton: some View {
        Button {
            coordinator.popToBuilder()
        } label: {
            Image(.backArrow)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

extension View {
    func bold(_ size: CGFloat) -> some View {
         font(.bold(size))
    }
    
    func semibold(_ size: CGFloat) -> some View {
        font(.semibold(size))
    }
    
    func regular(_ size: CGFloat) -> some View {
        font(.regular(size))
    }
    
    func medium(_ size: CGFloat) -> some View {
        font(.medium(size))
    }
    
    func customNavBar(title: String, completion: (() -> Void)? = nil) -> some View {
        self.modifier(CustomizedNavigationBar(title: title, dismissCompletion: completion))
    }
}
