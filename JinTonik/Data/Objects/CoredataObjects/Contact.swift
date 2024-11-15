import Foundation
import CoreData

final class Contact: ResumeField {
    override class var keyPath: String { "contact" }
    @NSManaged var resume: Resume
    @NSManaged var email: String
    @NSManaged var telephone: String
    @NSManaged var profile: String
    
    convenience init(_ managedContext: NSManagedObjectContext) {
        self.init(context: managedContext)
        self.email = ""
        self.telephone = ""
        self.profile = ""
    }
    
    override var valuesToDisplay: [String] {
        let email = !email.isEmpty ? email : "Email"
        let telephone = !telephone.isEmpty ? telephone : "Telephone"
        let profile = !profile.isEmpty ? profile : "Profile URL"
        
        return [email, telephone, profile]
    }
    
    override var isFilled: Bool {
        !(email.isEmpty && telephone.isEmpty && profile.isEmpty)
    }
}
