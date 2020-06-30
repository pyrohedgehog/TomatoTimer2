//
//  TaskHandler.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-24.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
import UIKit
class TaskHandler :Codable, TaskElement{
    func onShortClick() -> UIViewController {
        let controller = ItemDisplayViewController(self, StartScreenViewController.archive)
        return controller
    }
    
    /**
     The class for handling all the tomatos in a single agenda.
     */
    var title    : String = ""
    var id      : String
    var tasks : [TaskElement]
    var moreInfo : String = ""
    
    init(_ id : String){
        self.tasks = []
        self.id = id
        loadPreviousSave()
    }
    required init(from decoder: Decoder) throws {
        fatalError("decoding not setup yet")
    }
    func encode(to encoder: Encoder) throws {
        fatalError("not setup yet")
    }
    
    func loadPreviousSave(){
        let hasBeenSavedBefore = defaults.bool(forKey: id + keys.hasIdBeenSavedBefore)
        if(hasBeenSavedBefore){
            self.title = defaults.string(forKey: id + keys.nameSave)!//not angry coding, if it has been saved than it MUST have a name
            self.moreInfo = defaults.string(forKey: id + keys.moreInfoSave) ?? ""
            loadAllTomatos()
        }else{
            saveCurrentSave()
        }
    }
    func saveCurrentSave(){
        if (title == ""){
            title = "Click to define Name"
        }
        defaults.set(true, forKey: id + keys.hasIdBeenSavedBefore)
        defaults.set(title, forKey: id + keys.nameSave)
        defaults.set(moreInfo, forKey: id + keys.moreInfoSave)
        saveAllTomatos()
    }
    
    func makeTutorial(){
        /**
         makes the tutorial TomatoHandler. Only call if its the first time the user makes an "account"
         */
        self.tasks = [Tomato("Hello", "click on tasks to edit them", self.id),Tomato("world","click on tasks to edit them", self.id)]
        self.title = "Tutorial"
        self.saveCurrentSave()
    }
    let defaults = UserDefaults.standard
    struct keys{
        static let tomatosCount             = " NumberOfTomatos"
        static let hasIdBeenSavedBefore     = "Has id been used or saved before"
        static let nameSave                 = "Name Save point"
        static let moreInfoSave             = "More Info Save Point"
    }
    
    //TODO: this will cause errors if user has multiple agendas with the same name...
    func saveAllTomatos(){
        let encoder = JSONEncoder()
        defaults.set(tasks.count, forKey: self.id+keys.tomatosCount)
        
        for index in 0..<tasks.count{
            if (tasks[index] is Tomato){//tomato case
                let current :Tomato = tasks[index] as! Tomato
                if let encoded = try? encoder.encode(current) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: self.id+" "+String(index))
                }
            }else{//non tomato case
                let current = (tasks[index] as! TaskHandler).id
                (tasks[index] as! TaskHandler).saveCurrentSave()
                if let encoded = try? encoder.encode(current) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: self.id+" "+String(index))
                }
            }
        }
    }
    
    func loadAllTomatos(){
//        print("loading all tomatos")
        tasks = []
        let tomatoCount = defaults.integer(forKey: self.id+keys.tomatosCount)
        for index in 0..<tomatoCount{
            if let savedPerson = defaults.object(forKey: self.id+" "+String(index)) as? Data {
                let decoder = JSONDecoder()
                if let loadedTomato = try? decoder.decode(Tomato.self, from: savedPerson) {
                    tasks.append(loadedTomato)
                }else if let loaded = try? decoder.decode(String.self, from: savedPerson){
                    let loadedTask = TaskHandler(loaded)
                    tasks.append(loadedTask)
                }
            }
        }
    }
    
    func addTomato(_ tomato:Tomato){
        //additional information such as time added set here
        self.tasks.append(tomato)
        if(self.id == "Archive"){
            print("added to archived file")
        }
        saveAllTomatos()
    }
    func addTask(_ task:TaskElement){
        self.tasks.append(task)
        saveAllTomatos()
//        saveCurrentSave()
        if(self.id == "Archive"){
            print("added to archived file")
        }
    }
}
