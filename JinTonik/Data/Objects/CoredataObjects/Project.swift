import CoreData

final class ProjectList: ListMultilineObject {
    override class var keyPath: String { "project" }
    override var commonFields: [String] { ["Project name", "Project URL", "Period"] }
}
