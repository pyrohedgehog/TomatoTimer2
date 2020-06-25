//
//  TaskElement.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-22.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
import UIKit

protocol TaskElement : Codable{
    var title : String { get }
    var moreInfo : String { get}
    func onShortClick() -> UIViewController
}
//extension TaskElement {
//
//
//}
class TaskElementCell : UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func setText(tomato: Tomato){
        //  nameLabel.text = tomato.name
        textLabel?.text = tomato.title
        detailTextLabel?.text = tomato.moreInfo
    }
    func setText(agenda : TaskHandler){
        textLabel?.text = agenda.title
        detailTextLabel?.text = agenda.moreInfo
    }
    func setText(_ task: TaskElement){
        textLabel?.text = task.title
        detailTextLabel?.text = task.moreInfo
    }
}
