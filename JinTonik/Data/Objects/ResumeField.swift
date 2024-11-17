import Foundation
import CoreData

protocol ResumeField: NSManagedObject, Identifiable {
    var isFilled: Bool { get }
    var category: MainCategory { get }
    var valuesToDisplay: [String] { get }
}
