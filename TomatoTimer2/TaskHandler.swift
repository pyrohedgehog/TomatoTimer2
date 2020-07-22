//
//  TaskHandler.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-24.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
import UIKit
class TaskHandler :Codable, TaskElement {
    func onShortClick() -> UIViewController {
        let controller = ItemDisplayViewController(self, UserStoarage.user().mainArchive)
        return controller
    }
    
    /**
     The class for handling all the tomatos in a single agenda.
     */
    var title = ""
    var id: String
    var tasks: [TaskElement]
    var moreInfo: String = ""
    var colorPattern = "light"
    
    
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
        let hasBeenSavedBefore = UserStoarage.defaults.bool(forKey: id + UserStoarage.keys.hasIdBeenSavedBefore)
        if(hasBeenSavedBefore){
            self.title = UserStoarage.defaults.string(forKey: id + UserStoarage.keys.nameSave) ?? ""
            self.moreInfo = UserStoarage.defaults.string(forKey: id + UserStoarage.keys.moreInfoSave) ?? ""
            self.colorPattern = UserStoarage.defaults.string(forKey: id + UserStoarage.keys.colorPatternName) ?? ""
            loadAllTomatos()
        }else{
            saveCurrentSave()
        }
    }
    func saveCurrentSave(){
        UserStoarage.defaults.set(true, forKey: id + UserStoarage.keys.hasIdBeenSavedBefore)
        UserStoarage.defaults.set(title, forKey: id + UserStoarage.keys.nameSave)
        UserStoarage.defaults.set(moreInfo, forKey: id + UserStoarage.keys.moreInfoSave)
        UserStoarage.defaults.set(colorPattern, forKey: id + UserStoarage.keys.colorPatternName)
        saveAllTomatos()
    }
    
    func makeTutorial(){
        /**
         makes the tutorial TomatoHandler. Only call if its the first time the user makes an "account"
         */
        self.tasks = [Tomato("Hello", "click on tasks to edit them"), Tomato("world","click on tasks to edit them")]
        self.title = "Tutorial"
        self.saveCurrentSave()
    }
    
    //TODO: this will cause errors if user has multiple agendas with the same name...
    func saveAllTomatos(){
        let encoder = JSONEncoder()
        UserStoarage.defaults.set(tasks.count, forKey: self.id+UserStoarage.keys.tomatosCount)
        
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
        tasks = []
        let tomatoCount = UserStoarage.defaults.integer(forKey: self.id+UserStoarage.keys.tomatosCount)
        for index in 0..<tomatoCount{
            if let savedPerson = UserStoarage.defaults.object(forKey: self.id+" "+String(index)) as? Data {
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
        if(self.id == "Archive"){
            print("added to archived file")
        }
    }
    func deleteAllTasks(){
        for x in tasks{
            if(x is TaskHandler){
                (x as! TaskHandler).deleteAllTasks()
            }
        }
        tasks.removeAll()
    }
}
