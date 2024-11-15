import CoreData

final class Profile: ResumeField {
    override class var keyPath: String { "profile" }
    @NSManaged var resume: Resume
    @NSManaged var name: String
    @NSManaged var jobTitle: String
    @NSManaged var location: String
    @NSManaged var imageData: Data?
    @NSManaged var about: String
    
    convenience init(resume: Resume, _ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.resume = resume
        self.name = ""
        self.jobTitle = ""
        self.location = ""
        self.about = ""
    }
    
    override var valuesToDisplay: [String] {
        let name = name.isEmpty ? "Name" : name
        let jobtitle = jobTitle.isEmpty ? "Job title" : jobTitle
        let location = location.isEmpty ? "Location" : location
        
        return [name, jobtitle, location]
    }
    
    override var isFilled: Bool {
        !(name.isEmpty && jobTitle.isEmpty && location.isEmpty)
    }
}
