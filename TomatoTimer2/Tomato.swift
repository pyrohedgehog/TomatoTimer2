import Foundation
import UIKit
class Tomato : Codable, TaskElement{
    func onShortClick() -> UIViewController {
        return TaskDesignerViewController(self, resolveAction)
        
    }
    func resolveAction(_ tomato : TaskElement){
        //TODO Setup the save function...
        print("")
    }
    
    var title: String
    var moreInfo: String // description of what it does
    
    init(_ name:String){
        self.title = name
        self.moreInfo = "Click To Add More info!"
    }
    
    init(_ name:String, _ moreInfo:String){
        self.moreInfo = moreInfo
        self.title = name
    }
}
