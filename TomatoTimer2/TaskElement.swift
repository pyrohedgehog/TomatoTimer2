//
//  TaskElement.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-22.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
import UIKit

protocol TaskElement : Codable {
    var title : String { get set}
    var moreInfo : String { get set}
    func onShortClick() -> UIViewController
//    func encodeWithCoder(acoder: NSCoder!)
//    func decodeWithCoder(acoder: NSCoder!)
}



class TaskElementCell : UITableViewCell {
    let backgroundColourValue : UIColor = .white
    let textColour : UIColor = .black
    let detailColour : UIColor = .gray
    
    init(_ colorPattern: ColorPattern) {
        super.init(style: .subtitle, reuseIdentifier: "taskCell")
        self.backgroundColor = colorPattern.backgrounColor
        self.textLabel?.textColor = colorPattern.mainTextColor
        self.detailTextLabel?.textColor = colorPattern.subTextColor
    }
    
    required init?(coder: NSCoder) {//required
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setText(_ task: TaskElement) {
        textLabel?.text = task.title
        detailTextLabel?.text = task.moreInfo
    }
}
