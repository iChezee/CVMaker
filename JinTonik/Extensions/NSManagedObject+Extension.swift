import CoreData

extension NSManagedObject {
    public class func fetchRequest<T>() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: Self.entity().name!)
    }
}
