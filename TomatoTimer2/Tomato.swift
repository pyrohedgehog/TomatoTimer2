import Foundation
import UIKit
class Tomato{
    var name: String
    var description: String // description of what it does
    
    init(_ name:String){
        self.name = name
        self.description = ""
    }
    
    init(_ name:String, _ description: String){
        self.name = name
        self.description = description
    }
}
