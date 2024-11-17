import CoreData

@objc(ListMultilineObject)
class ListMultilineObject: NSManagedObject, ResumeField {
    @NSManaged var objects: Set<MultilineObject>
    @NSManaged var categoryName: String
    var category: MainCategory {
        MainCategory(rawValue: categoryName)!
    }
    
    convenience init(category: MainCategory, context: NSManagedObjectContext) {
        self.init(context: context)
        self.categoryName = category.rawValue
    }
    
    var valuesToDisplay: [String] {
        var valuesToShow: [String] = []
        if let object = objects.first(where: { !$0.title.isEmpty || !$0.specialisation.isEmpty }) {
            if !object.title.isEmpty {
                valuesToShow.append(object.title)
            }
            
            if !object.specialisation.isEmpty {
                valuesToShow.append(object.specialisation)
            }
            
            if !object.period.isEmpty {
                valuesToShow.append(object.period)
            }
        } else {
            valuesToShow = category.commonFields
        }
        
        return valuesToShow
    }
    
    var isFilled: Bool {
        !objects.isEmpty
    }
}

class MultilineObject: NSManagedObject, Identifiable {
    @NSManaged var title: String
    @NSManaged var specialisation: String
    @NSManaged var period: String
    @NSManaged var location: String
    @NSManaged var about: String
    @NSManaged var present: Bool
    @NSManaged var timestamp: Date
    @NSManaged var list: ListMultilineObject
    
    convenience init(title: String = "", specialisation: String = "", period: String = "", location: String = "", about: String = "", present: Bool = false, list: ListMultilineObject, managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.title = title
        self.specialisation = specialisation
        self.period = period
        self.location = location
        self.about = about
        self.present = present
        self.timestamp = Date()
        self.list = list
    }
    
    convenience init(_ object: MultilineTempObject, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = object.title
        self.specialisation = object.specialisation
        self.period = object.period
        self.location = object.location
        self.about = object.about
        self.present = object.present
        self.timestamp = Date()
        self.list = object.list
        object.list.objects.insert(self)
    }
    
    func updateFields(_ object: MultilineTempObject) {
        self.title = object.title
        self.specialisation = object.specialisation
        self.period = object.period
        self.location = object.location
        self.about = object.about
        self.present = object.present
    }
}

struct MultilineTempObject {
    var title: String = ""
    var specialisation: String = ""
    var period: String = ""
    var location: String = ""
    var about: String = ""
    var present: Bool = false
    var list: ListMultilineObject
    var existedObject: MultilineObject?
    
    init(_ list: ListMultilineObject) {
        self.list = list
    }
    
    init(_ object: MultilineObject, list: ListMultilineObject) {
        self.title = object.title
        self.specialisation = object.specialisation
        self.period = object.period
        self.location = object.location
        self.about = object.about
        self.present = object.present
        self.list = list
        self.existedObject = object
    }
}
