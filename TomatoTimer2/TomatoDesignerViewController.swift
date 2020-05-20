//
//  TomatoDesignerViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-05-20.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class TomatoDesignerViewController: UIViewController{
    //MARK: view variables
    var cellId = "controlCells"
    
    var safeArea = UILayoutGuide()
    let tableView = UITableView()
    var viewElements:[UITableViewCell] = []
    
    //load function
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        print("view loaded")
        view.backgroundColor = .white //set it to the color that you prefer
        
        
        
        setupTableView(self.view)
        setupSaveButton(self.view)
    }
    func setupSaveButton(_ inputView: UIView){
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = save
        print("save button loaded")
    }
    @objc func saveButtonClicked(_ sender: UIButton){
        
        print("save button clicked, not setup")
    }
    
    
    func setupTableView(_ inputView: UIView){
        /**
         Setup the table
         */
        let view = inputView
        var safeArea  = UILayoutGuide()
        safeArea = view.layoutMarginsGuide
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        
        loadTableData()
        tableView.register(TomatoCell.self, forCellReuseIdentifier: cellId)
        
        print("table loaded")
    }
    
    
    
    func loadTableData(){
        //TODO: actually make this load data from a saved point
        //setup UI table cells here
        //looking into MVVM or MVC data setup
        //
    }
}






extension TomatoDesignerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print("getting cell")
        
        return viewElements[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   
}

