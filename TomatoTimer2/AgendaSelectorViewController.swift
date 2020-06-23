//
//  AgendaSelectorViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-01.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class AgendaSelectorViewController: UIViewController {
    var agendas : [TomatoHandler] = []
    var handlerNames : [String] = []
    var archiveAgenda:TomatoHandler = TomatoHandler("Archive")
    var cellId = "agendaCellId"
    var safeArea = UILayoutGuide()
    let tableView = UITableView()
    
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
        let vc = AgendaDesignerViewController(TomatoHandler(generateNewAgendaId()),saveAddedAgenda)
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
        return "this shouldnt happen, but if it does, you'll see this appear in the logs"
    }
    
    func saveAddedAgenda(_ handler:TomatoHandler){
        handlerNames.append(handler.id)
        agendas.append(handler)
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
        /**
         load all the stuffs i need to load on launch
         */
        agendas = []
        self.handlerNames = defaults.stringArray(forKey: keys.names) ?? [String]()
        let previouslyLoaded = defaults.bool(forKey: keys.previouslyLoaded)
        if(previouslyLoaded){
            for foo in handlerNames{
                let element = TomatoHandler(foo)
                agendas.append(element)
            }
        }else{
            self.archiveAgenda = TomatoHandler("Archive")
            archiveAgenda.name = "Archived Files"
            handlerNames.append(archiveAgenda.id)
            archiveAgenda.saveCurrentSave()
            agendas.append(archiveAgenda)//TODO: archive is important... maybe makesure no one deletes it... hell, maybe give it its own page...
            
            
            let tutorial = TomatoHandler("Tutorial")
            tutorial.makeTutorial()
            handlerNames.append(tutorial.id)
            agendas.append(tutorial)
        }
        self.tableView.reloadData()
        saveData()
    }
    func saveData(){
        /**
         save the agendas here(only actually save the names here. handle saving smaller data inside of the handler)
         */
        defaults.set(handlerNames, forKey: keys.names)
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
        tableView.register(TomatoCell.self, forCellReuseIdentifier: cellId)
    }
}


extension AgendaSelectorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.agendas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print("getting cell")
        let agenda = agendas[indexPath.row]
        agenda.loadAllTomatos()
        let cell = AgendaCell.init(style: .subtitle, reuseIdentifier: "foo")
        cell.setText(agenda.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//        let data = agendas[indexPath.row]
        let data = TomatoHandler(handlerNames[indexPath.row])
        data.loadAllTomatos()
        print("Name Of: " + data.name)
        let handlerController = AgendaViewController(data, archiveAgenda)
        navigationController?.pushViewController(handlerController, animated: true)
        
    }
}
class AgendaCell: UITableViewCell {
    // @IBOutlet weak var nameLabel: UILabel!
    var nameLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setText(_ textValue: String){
        textLabel?.text = textValue
    }
    
}
