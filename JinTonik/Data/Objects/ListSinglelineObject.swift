import CoreData

class ListSinglelineObject: ResumeField {
    override class var keyPath: String { "" }
    @NSManaged var objects: Set<SinglelineObject>
    var commonField: String { "" }
    
    convenience init(_ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
    }
    
    override var valuesToDisplay: [String] {
        let names = objects.map { $0.name }
        
        return names.isEmpty ? [commonField] : names
    }
    
    override var isFilled: Bool {
        !objects.isEmpty
    }
}

class SinglelineObject: NSManagedObject, Identifiable {
    @NSManaged var name: String
    @NSManaged var mark: String
    @NSManaged var list: ListSinglelineObject
    
    convenience init(name: String = "", mark: String = "0", list: ListSinglelineObject, managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.name = name
        self.mark = mark
        self.list = list
    }
    
    convenience init(_ tempObject: SinglelineTempObject, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = tempObject.name
        self.mark = tempObject.mark
        tempObject.list.objects.insert(self)
    }
    
    func updateFields(_ tempObject: SinglelineTempObject) {
        self.name = tempObject.name
        self.mark = tempObject.mark
    }
}

struct SinglelineTempObject {
    var name: String = ""
    var mark: String = "0"
    var list: ListSinglelineObject
    var existedObject: SinglelineObject?
    
    init(_ list: ListSinglelineObject) {
        self.list = list
    }
    
    init(_ object: SinglelineObject, list: ListSinglelineObject) {
        self.name = object.name
        self.mark = object.mark
        self.list = object.list
        self.existedObject = object
    }
}
