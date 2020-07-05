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
    var title : String { get set}
    var moreInfo : String { get set}
    func onShortClick() -> UIViewController
}
//extension TaskElement {
//
//
//}
class TaskElementCell : UITableViewCell{
    let backgroundColourValue : UIColor = .white
    let textColour : UIColor = .black
    let detailColour : UIColor = .gray
    
    
    init(){
        super.init(style: .subtitle, reuseIdentifier: "taskCell")
        self.backgroundColor = backgroundColourValue
        self.textLabel?.textColor = textColour
        self.detailTextLabel?.textColor = detailColour
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = backgroundColourValue
        self.textLabel?.textColor = textColour
        self.detailTextLabel?.textColor = detailColour
    }
    
    required init?(coder: NSCoder) {//required
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setText(_ task: TaskElement){
        textLabel?.text = task.title
        detailTextLabel?.text = task.moreInfo
    }
}
