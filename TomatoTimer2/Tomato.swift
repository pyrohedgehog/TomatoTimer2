import Foundation
import UIKit
class Tomato{
    var name: String
    var description: String // description of what it does
    
    init(_ name:String){
        self.name = name
        self.description = "Click To Enter Description"
    }
    init(){
        self.name = "Click To Enter A Title"
        self.description = "Click To Enter Description"
    }
    
    init(_ name:String, _ description: String){
        self.name = name
        self.description = description
    }
}
