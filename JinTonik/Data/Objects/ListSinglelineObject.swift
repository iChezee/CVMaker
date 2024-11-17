import CoreData

@objc(ListSinglelineObject)
class ListSinglelineObject: NSManagedObject, ResumeField {
    @NSManaged var objects: Set<SinglelineObject>
    @NSManaged var categoryName: String
    var category: MainCategory {
        MainCategory(rawValue: categoryName)!
    }
    
    convenience init(category: MainCategory, managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.categoryName = category.rawValue
    }
    
    var valuesToDisplay: [String] {
        let names = objects.map { $0.name }.filter { !$0.isEmpty }
        
        return names.isEmpty ? category.commonFields : names
    }
    
    var isFilled: Bool {
        !objects.isEmpty
    }
}

class SinglelineObject: NSManagedObject, Identifiable {
    @NSManaged var name: String
    @NSManaged var mark: String
    @NSManaged var timestamp: Date
    @NSManaged var list: ListSinglelineObject
    
    convenience init(name: String = "", mark: String = "0", list: ListSinglelineObject, managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.name = name
        self.mark = mark
        self.timestamp = Date()
        self.list = list
    }
    
    convenience init(_ tempObject: SinglelineTempObject, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = tempObject.name
        self.mark = tempObject.mark
        self.timestamp = Date()
        self.list = tempObject.list
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
