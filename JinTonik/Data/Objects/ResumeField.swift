import Foundation
import CoreData

class ResumeField: NSManagedObject, Identifiable {
    class var keyPath: String { "" }
    var isFilled: Bool { false }
    var category: MainCategory { MainCategory(rawValue: Self.keyPath)! }
    
    var valuesToDisplay: [String] { ["World"] }
}
