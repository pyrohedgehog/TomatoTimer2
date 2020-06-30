import Foundation
import UIKit
class Tomato : Codable, TaskElement{
    func onShortClick() -> UIViewController {
        return TomatoDesignerViewController(self, resolveAction)
        
    }
    func resolveAction(_ tomato : Tomato){
        //TODO Setup the save function...
        print("")
    }
    
    var title: String
    var moreInfo: String // description of what it does
    
    var originId: String//just the first handler to spawn the tomato. Useful for future stats per assignment based on archived tomatos
    
    
    init(_ name:String, _ origin:String){
        self.originId = origin
        self.title = name
        self.moreInfo = "Click To Enter Description"
    }
    init(_ origin:String){
        self.title = "Click To Enter A Title"
        self.moreInfo = "Click To Enter Description"
        self.originId = origin
    }
    
    init(_ name:String, _ description: String, _ origin:String){
        self.title = name
        self.moreInfo = description
        self.originId = origin
    }
}
