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
//        let vc = CreateTomatoViewController(addTomato)
        let tomato = Tomato()
        let vc = TomatoDesignerViewController(tomato, addTomato)
        navigationController?.pushViewController(vc, animated: true)
//        vc.dismiss(animated: true, completion: nil) // i dont remember what this does, so im keeping this comment here for when something stops working
        
        
//        tomatos.popLast()
//        print(tomatos.count)
    }
    
    
    
    func loadTableData(){
        //TODO: actually make this load data from a saved point
        self.tomatos = [Tomato("Hello"),Tomato("world")]
    }
    
    
    
    func addTomato(_ tomato:Tomato){
        //used to add new tomatos, passed to the Create Tomato View on construction
        print("new tomato added")
        tomatos.append(tomato)
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let tomatoController = EditTomatoViewController(tomatos[indexPath.row])
        navigationController?.pushViewController(tomatoController, animated: true)
        
    }
    
    
    //TODO: LIST
    //write cell creator page
    //write tomato creator button functionalitty
    //write on click function for already created cells
    //add swipe interface
    
    
//    func tableView(_ tableView: UITableView,
//                   heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
}

