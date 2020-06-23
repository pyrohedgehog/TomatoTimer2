//
//  TaskElement.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-22.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
import UIKit

//protocol TaskElement{
//
//}
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
        textLabel?.text = tomato.name
        detailTextLabel?.text = tomato.description
    }
    func setText(agenda : TomatoHandler){
        textLabel?.text = agenda.name
        detailTextLabel?.text = agenda.moreInfo
    }
}
