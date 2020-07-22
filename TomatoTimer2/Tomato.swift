import Foundation
import UIKit
class Tomato : Codable, TaskElement{
    func onShortClick() -> UIViewController {
        return TaskEditorViewController(self, resolveAction)
        
    }
    func resolveAction(_ tomato : TaskElement){
        //TODO: Created a saving action based on the individual tomato being editied
//        UserStoarage.user().mainAgenda.saveAllTomatos()
        
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
