//
//  TomatoCell.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-04-15.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class TomatoCell: UITableViewCell {
    // @IBOutlet weak var nameLabel: UILabel!
    var nameLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setText(_ tomato: Tomato){
      //  nameLabel.text = tomato.name
        textLabel?.text = tomato.name
        detailTextLabel?.text = tomato.description
    }
    
}
