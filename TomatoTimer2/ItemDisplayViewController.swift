//
//  ItemDisplayViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-23.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class ItemDisplayViewController: UIViewController {
    //replaces AgendaViewController and AgendaSelectorViewController with this one class
    var agendas: TaskHandler
//    var handlerNames: [String] = []//i want to remove this, but havent gotten to it yet
    var archiveAgenda: TaskHandler
    let cellId = "agendaCellId"
    var safeArea = UILayoutGuide()
    let tableView = UITableView()
    var colorPattern: ColorPattern
    
    init(_ handlerString: String) {
        self.agendas = TaskHandler(handlerString)
        self.archiveAgenda = UserStoarage.user().mainArchive
        self.colorPattern = ColorPattern.getColor(agendas.colorPattern)
        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ taskHandler:TaskHandler, _ archive:TaskHandler) {
        self.archiveAgenda = archive
        self.agendas = taskHandler
        self.colorPattern = ColorPattern.getColor(agendas.colorPattern)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = UserStoarage.user().saveAll()
        
        
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = colorPattern.backgrounColor
        loadData()
        setupTableView(self.view)
        setupCreationBarButton(self.view)
        
    }
    func setupCreationBarButton(_ view:UIView) {
        if (agendas.title != "Click to define Name") {
            navigationItem.title = agendas.title
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonClicked))
    }
    @objc func createButtonClicked(_ sender: UIButton) {
        let createdTask = TaskHandler("")//TODO: once cloud system is implemented, no id will need to be passed
        createdTask.title = ""//fixes the bug of new tasks appearing with the title last entered
        createdTask.moreInfo = ""
        let vc = TaskEditorViewController(createdTask,saveAddedAgenda)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func saveAddedAgenda(_ handler:TaskElement){

        agendas.tasks.append(handler)
        self.saveData()
        loadData()
        self.tableView.reloadData()
    }
    
    
    
    func loadData(){
        agendas.loadPreviousSave()
        
        self.tableView.reloadData()
    }
    func saveData(){
        agendas.saveCurrentSave()
        UserStoarage.defaults.set(true, forKey: UserStoarage.keys.previouslyLoaded)
    }
    
    
    func setupTableView(_ inputView: UIView){
        /**
         Setup the table
         */
        let view = inputView
        tableView.backgroundColor = colorPattern.backgrounColor
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
        
        tableView.register(TaskElementCell.self, forCellReuseIdentifier: cellId)
    }
}


extension ItemDisplayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.agendas.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = agendas.tasks[indexPath.row]
        let cell = TaskElementCell.init(colorPattern)
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
