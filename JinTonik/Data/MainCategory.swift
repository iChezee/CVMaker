import SwiftUI
import SwiftData

enum MainCategory: String {
    case profile
    case contact
    case employment
    case education
    case skills
    case software
    case project
    case language
    case hobbie
    
    var image: Image {
        Image(rawValue)
    }
    
    var title: String {
        rawValue.capitalizedFirst
    }
}
