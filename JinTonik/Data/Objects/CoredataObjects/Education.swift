import CoreData

final class EducationList: ListMultilineObject {
    override class var keyPath: String { "education" }
    override var commonFields: [String] { ["University", "Specialization", "Period"] }
}
