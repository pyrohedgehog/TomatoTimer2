//
//  TomatoSelectViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-05-22.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class TomatoSelectViewController: UIViewController {
    var tomato:Tomato
    init(_ tomato:Tomato){
        self.tomato = tomato
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
