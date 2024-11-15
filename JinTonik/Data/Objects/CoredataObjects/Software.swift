import CoreData

final class SoftwareList: ListSinglelineObject {
    override class var keyPath: String { "software" }
    override var commonField: String { "Software name" }
}
