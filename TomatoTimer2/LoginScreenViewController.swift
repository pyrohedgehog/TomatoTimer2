//
//  ViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-04-15.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit
// learning notes. I need the Main.storyboard, App delegate will throw unknown errors without it.
//
//
//
class LoginScreenViewController: UIViewController{
    //MARK: view variables
    var safeArea: UILayoutGuide!
    let tableView = UITableView()
    var tomatos:[Tomato] = []
    
    //load function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white //set it to the color that you prefer
        
        setupTableView()
    }
    
    func setupTableView() {
        /**
        Setup the table
         */
        view.addSubview(self.tableView);
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
        
        
    
    
    
    func loadTableData(){
        //TODO: actually make this load data from a saved point
        self.tomatos = [Tomato("Hello"),Tomato("world")]
    }

}

extension LoginScreenViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tomatos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tomato = tomatos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TomatoCell") as! TomatoCell
        
        cell.setText(tomato)
        
        return cell
        
    }
}
