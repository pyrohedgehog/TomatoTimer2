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
    var cellId = "cellId"
    var safeArea = UILayoutGuide()
    let tableView = UITableView()
    var tomatos:[Tomato] = []
    //load function
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        print("view loaded")
        view.backgroundColor = .white //set it to the color that you prefer
        

        
        setupTableView(self.view)
        setupCreateButton(self.view)
    }
    func setupCreateButton(_ inputView: UIView){
//old button method that loads in the page and not in the bar!
//        let view = inputView
//        view.backgroundColor = UIColor.white
//        let createButton:UIButton = UIButton(type: .system)
//        let size = 40
//        //y value i had before was 30
//        createButton.frame = CGRect(x:350, y: 70, width: size, height: size)
//        createButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
//        createButton.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
//        createButton.setTitle("+", for: .normal)
//        view.addSubview(createButton)
        
        
        
        let append = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonClicked))
        navigationItem.rightBarButtonItem = append
        
        
        print("button loaded")
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
        
    @objc func createButtonClicked(_ sender: UIButton) {
        //TODO: make page for creating tomatos
        print("button clicked!")
        let vc = CreateTomatoViewController()
        navigationController?.pushViewController(vc, animated: true)
//        vc.dismiss(animated: true, completion: nil)
    }
    
    
    
    func loadTableData(){
        //TODO: actually make this load data from a saved point
        self.tomatos = [Tomato("Hello"),Tomato("world")]
    }

}

extension LoginScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tomatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("getting cell")
        let tomato = tomatos[indexPath.row]
        let cell = TomatoCell.init(style: .subtitle, reuseIdentifier: "foo")
        cell.setText(tomato)
        
        return cell
    }
    
    //TODO: LIST
    //write cell creator page
    //write on click function for already created cells
    //add swipe interface
    
    
//    func tableView(_ tableView: UITableView,
//                   heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
}

