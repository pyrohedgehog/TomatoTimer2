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
//        let tomato = Tomato()
//        let vc = TomatoDesignerViewController(tomato, addTomato)
//        navigationController?.pushViewController(vc, animated: true)
        
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
            agendas.append(archiveAgenda)//TODO: archive is important... maybe makesure noone deletes it... hell, maybe give it its own page...
            
            
            let tutorial = TomatoHandler("Tutorial")
            tutorial.makeTutorial()
            handlerNames.append(tutorial.id)
            agendas.append(tutorial)
            saveData()
        }
    }
    func saveData(){
        /**
         save the agendas here(only actually save the names here. handle saving smaller data inside of the handler
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
        let cell = AgendaCell.init(style: .subtitle, reuseIdentifier: "foo")
        cell.setText(agenda.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let data = agendas[indexPath.row]
        data.loadAllTomatos()
        let handlerController = AgendaViewController(data)
        navigationController?.pushViewController(handlerController, animated: true)
//        navigationController?.pushViewController(tomatoController, animated: true)
        
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
