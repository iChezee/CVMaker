import SwiftUI

@main
struct JinTonikApp: App {
    let container: PersistenceContainer
    
    init() {
        Fonts.WorkSans.registerAllCustomFonts()
        container = PersistenceContainer.shared
    }

    var body: some Scene {
        WindowGroup {
            MainCoordinator()
                .environment(\.managedObjectContext, container.viewContext)
                .environmentObject(container)
        }
    }
}
