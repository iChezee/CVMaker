import CoreData

final class Resume: NSManagedObject, Identifiable {
    @NSManaged var timestamp: Date
    @NSManaged var profile: Profile
    @NSManaged var contact: Contact
    @NSManaged var employment: ListMultilineObject
    @NSManaged var education: ListMultilineObject
    @NSManaged var project: ListMultilineObject
    @NSManaged var skills: ListSinglelineObject
    @NSManaged var software: ListSinglelineObject
    @NSManaged var language: ListSinglelineObject
    @NSManaged var hobbies: ListSinglelineObject
    
    convenience init(_ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.timestamp = Date()
        self.profile = Profile(resume: self, managedContext)
        self.contact = Contact(managedContext)
        self.employment = ListMultilineObject(category: .employment, context: managedContext)
        self.education = ListMultilineObject(category: .education, context: managedContext)
        self.project = ListMultilineObject(category: .project, context: managedContext)
        self.skills = ListSinglelineObject(category: .skills, managedContext: managedContext)
        self.software = ListSinglelineObject(category: .software, managedContext: managedContext)
        self.language = ListSinglelineObject(category: .language, managedContext: managedContext)
        self.hobbies = ListSinglelineObject(category: .hobbie, managedContext: managedContext)
    }
    
    var allFields: [any ResumeField] {
        [profile, contact, employment, education, skills, software, project, language, hobbies]
    }
}
