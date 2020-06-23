import Foundation
import UIKit
class Tomato : Codable{
    var name: String
    var description: String // description of what it does
    
    var originId: String//just the first handler to spawn the tomato. Useful for future stats per assignment based on archived tomatos
    
    
    init(_ name:String, _ origin:String){
        self.originId = origin
        self.name = name
        self.description = "Click To Enter Description"
    }
    init(_ origin:String){
        self.name = "Click To Enter A Title"
        self.description = "Click To Enter Description"
        self.originId = origin
    }
    
    init(_ name:String, _ description: String, _ origin:String){
        self.name = name
        self.description = description
        self.originId = origin
    }
}
