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
class AgendaViewController: UIViewController{
    //MARK: view variables
    var cellId = "cellId"
    var safeArea = UILayoutGuide()
    let tableView = UITableView()
    var tomatos:[Tomato] = []
    var handler:TomatoHandler
    
    init(_ tomatoHandler : TomatoHandler){
        self.handler = tomatoHandler
        
        super.init(nibName: nil, bundle: nil)
        tomatos = tomatoHandler.tomatos
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    
        
        tableView.register(TomatoCell.self, forCellReuseIdentifier: cellId)
        
        print("table loaded")
    }
        
    @objc func createButtonClicked(_ sender: UIButton) {
        let tomato = Tomato()
        let vc = TomatoDesignerViewController(tomato, addTomato)
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    func addTomato(_ tomato:Tomato){
        //used to add new tomatos, passed to the Create Tomato View on construction
        print("new tomato added")
        tomatos.append(tomato)
        handler.tomatos.append(tomato)
        saveTomatoChange(tomato)
    }
    func saveTomatoChange(_ tomato:Tomato){
        handler.saveAllTomatos()
        //TODO save the new tomato to long term storage
        tableView.reloadData()
        print("supposidly all tomatos are being saved")
        
    }

}

extension AgendaViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let tomatoController = TomatoDesignerViewController(tomatos[indexPath.row], saveTomatoChange)
        navigationController?.pushViewController(tomatoController, animated: true)
        
    }
    
    
    //TODO: LIST
    //add swipe interface
    
    
//    func tableView(_ tableView: UITableView,
//                   heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
}
