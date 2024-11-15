import CoreData

final class LanguageList: ListSinglelineObject {
    override class var keyPath: String { "language" }
    override var commonField: String { "Language name" }
}
