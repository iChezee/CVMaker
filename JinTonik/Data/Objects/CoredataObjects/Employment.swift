import CoreData

final class EmploymentList: ListMultilineObject {
    override class var keyPath: String { "employment" }
    override var commonFields: [String] { ["Company", "Specialization", "Period"] }
}
