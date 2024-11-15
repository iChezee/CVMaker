import CoreData

class PersistenceContainer: NSPersistentContainer, ObservableObject {
    static let shared = PersistenceContainer()
    
    private var savingQueue = OperationQueue()
    
    init(inMemory: Bool = false) {
        guard let model = NSManagedObjectModel.mergedModel(from: nil) else {
            fatalError("Can't load managed object models from bundle")
        }
        
        super.init(name: "JinTonik", managedObjectModel: model)
        
        if inMemory {
            if let persistentStoreDescription = persistentStoreDescriptions.first {
                persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
            }
        } else {
            viewContext.mergePolicy = NSOverwriteMergePolicy
            viewContext.automaticallyMergesChangesFromParent = true
        }
        
        loadPersistentStores(completionHandler: { (store, error) in
            if let error: NSError = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })    
    }
}

extension PersistenceContainer {
    func saveChanges(_ completion: ((Error?) -> Void)? = nil) {
        let operation = BlockOperation { [unowned self] in
            do {
                if viewContext.hasChanges {
                    try viewContext.save()
                }
                completion?(nil)
            } catch {
                completion?(error)
            }
        }
        
        savingQueue.addOperations([operation], waitUntilFinished: false)
    }
}
