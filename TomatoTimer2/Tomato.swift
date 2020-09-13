import Foundation
import UIKit
class Tomato: TaskElement {
//    override func onShortClick() -> UIViewController {
//        return TaskEditorViewController(self, resolveAction)
//        
//    }
    
    func resolveAction(_ tomato : TaskElement) {
        //TODO: Created a saving action based on the individual tomato being editied
//        UserStoarage.user().mainAgenda.saveAllTomatos()
    }
    
    enum CodingKeys: CodingKey {
        case title, moreInfo
    }
    init(_ name:String) {
        super.init()
        self.title = name
        self.moreInfo = "Click To Add More info!"
    }
    
    init(_ name:String, _ moreInfo:String) {
        super.init()
        self.moreInfo = moreInfo
        self.title = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        super.init()
        moreInfo = try container.decode(String.self, forKey: .moreInfo)
        title = try container.decode(String.self, forKey: .title)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(moreInfo, forKey: .moreInfo)
    }
}
