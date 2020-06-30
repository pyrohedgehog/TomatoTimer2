//
//  ItemDisplayViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-23.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class ItemDisplayViewController: UIViewController {
    //First, create a tableView
    //Create add button
    //replace AgendaViewController and AgendaSelectorViewController with this one class
    //
    var agendas : TaskHandler
    var handlerNames : [String] = []//i want to remove this, but havent gotten to it yet
    var archiveAgenda:TaskHandler
    var cellId = "agendaCellId"
    var safeArea = UILayoutGuide()
    let tableView = UITableView()
    
    
    init(_ handlerString: String){
        self.agendas = TaskHandler(handlerString)
        self.archiveAgenda = StartScreenViewController.archive
        super.init(nibName: nil, bundle: nil)
    }
    init(_ taskHandler:TaskHandler, _ archive:TaskHandler){
        self.archiveAgenda = archive
        self.agendas = taskHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        print("view loaded")
        view.backgroundColor = .white//may add a darkMode Later if i feel like it
        loadData()
        setupTableView(self.view)
        setupCreationBarButton(self.view)
        
    }
    func setupCreationBarButton(_ view:UIView){
        let append = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonClicked))
        navigationItem.rightBarButtonItem = append
    }
    @objc func createButtonClicked(_ sender: UIButton) {
        let vc = AgendaDesignerViewController(TaskHandler(generateNewAgendaId()),saveAddedAgenda)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func generateNewAgendaId() ->String{
        /**
         Creates the ID when the user creates a new agenda
         should have a better system, but it works
         */
        for x in 0 ... handlerNames.count+2{
            if(handlerNames.contains(String(x)) == false){
                return String(x)
            }
        }
        return "this shouldnt happen, but if it does, you'll see this appear in the logs. If this is in logs, fix your generateNewAgendaId function"
    }
    
    func saveAddedAgenda(_ handler:TaskHandler){
        handlerNames.append(handler.id)
        agendas.tasks.append(handler)
        handler.saveAllTomatos()
        self.saveData()
        loadData()
        self.tableView.reloadData()
    }
    
    
    
    
    
    let defaults = UserDefaults.standard
    struct keys{
        /**
         standard key storage for user defraults keys.
         */
        static let names            = "handlerIDS"
        static let previouslyLoaded = "hasAppPreviouslyBeenLaunched"
    }
    func loadData(){
        agendas.loadPreviousSave()
        
        self.tableView.reloadData()
    }
    func saveData(){
        agendas.saveCurrentSave()
        defaults.set(true, forKey: keys.previouslyLoaded)
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
        
        //        loadTableData()
        tableView.register(TaskElementCell.self, forCellReuseIdentifier: cellId)
    }
}


extension ItemDisplayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.agendas.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = agendas.tasks[indexPath.row]
//        let cell = AgendaCell.init(style: .subtitle, reuseIdentifier: "foo")
//
//        cell.setText(agenda.title)
        let cell = TaskElementCell.init()
        cell.setText(task)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let data = agendas.tasks[indexPath.row].onShortClick()
        navigationController?.pushViewController(data, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        /**
         swipe from the right features
         */
        let title = ""
        let archiveButton = UIContextualAction(style: .normal, title: title, handler: { (action, view, completionHandler) in
            //setup archiving system here
            self.archiveAgenda.addTask(self.agendas.tasks.remove(at: indexPath.row))
//            self.tomatos.remove(at: indexPath.row)
            self.archiveAgenda.saveCurrentSave()
            self.agendas.saveAllTomatos()
            self.tableView.reloadData()
            
            completionHandler(true)
        })
        
        let imageConfig = UIImage.SymbolConfiguration(weight: .semibold)//should make this configurable by user. So i dont have to pick anything besides the default
        
        archiveButton.image = UIImage(systemName: "archivebox.fill", withConfiguration: imageConfig)
        
        archiveButton.backgroundColor = UIColor(red: 116/256, green: 255/256, blue: 106/256, alpha: 100/256) //i havent picked a colour yet, but i kinda like the gray, but the green seems more fitting. might make a user selection for those
        //the green was kinda a randomly chosen green.
        let config = UISwipeActionsConfiguration(actions: [archiveButton])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
