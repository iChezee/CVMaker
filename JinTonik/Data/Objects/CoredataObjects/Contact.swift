import Foundation
import CoreData

final class Contact: NSManagedObject, ResumeField {
    @NSManaged var resume: Resume
    @NSManaged var email: String
    @NSManaged var telephone: String
    @NSManaged var profile: String
    var category: MainCategory = .contact
    
    convenience init(_ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.email = ""
        self.telephone = ""
        self.profile = ""
    }
    
    var valuesToDisplay: [String] {
        let email = !email.isEmpty ? email : "Email"
        let telephone = !telephone.isEmpty ? telephone : "Telephone"
        let profile = !profile.isEmpty ? profile : "Profile URL"
        
        return [email, telephone, profile]
    }
    
    var isFilled: Bool {
        !(email.isEmpty && telephone.isEmpty && profile.isEmpty)
    }
}
