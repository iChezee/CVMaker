import CoreData

final class Resume: NSManagedObject, Identifiable {
    @NSManaged var timestamp: Date
    @NSManaged var profile: Profile
    @NSManaged var contact: Contact
    @NSManaged var employment: EmploymentList
    @NSManaged var education: EducationList
    @NSManaged var project: ProjectList
    @NSManaged var skills: SkillsList
    @NSManaged var software: SoftwareList
    @NSManaged var language: LanguageList
    @NSManaged var hobbies: HobbieList
    
    
    convenience init(_ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.timestamp = Date()
        self.profile = Profile(resume: self, managedContext)
        self.contact = Contact(managedContext)
        self.employment = EmploymentList(managedContext)
        self.education = EducationList(managedContext)
        self.skills = SkillsList(managedContext)
        self.software = SoftwareList(managedContext)
        self.project = ProjectList(managedContext)
        self.language = LanguageList(managedContext)
        self.hobbies = HobbieList(managedContext)
    }
    
    var allFields: [ResumeField] {
        [profile, contact, employment, education, skills, software, project, language, hobbies]
    }
}
