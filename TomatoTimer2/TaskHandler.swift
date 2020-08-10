//
//  TaskHandler.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-24.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
import UIKit
class TaskHandler: TaskElement {
    override func onShortClick() -> UIViewController {
        let controller = ItemDisplayViewController(self, UserStoarage.user().mainArchive)
        return controller
    }
    
    /**
     The class for handling all the tomatos in a single agenda.
     */
    var tasks: [TaskElement]
    var colorPattern = "light"
    
    
    init(_ id : String){
        self.tasks = []
        super.init()
        loadPreviousSave()
    }
    
    
    enum CodingKeys: CodingKey {
        case title, tasks, moreInfo, colorPattern
    }
    
    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        tasks = try container.decode([TaskElement].self, forKey: .tasks)
        super.init()
        moreInfo = try container.decode(String.self, forKey: .moreInfo)
        title = try container.decode(String.self, forKey: .title)
        self.colorPattern = try container.decode(String.self, forKey: .colorPattern)
    }
    
    
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        
        
        try container.encode(tasks, forKey: .tasks)

        try container.encode(moreInfo, forKey: .moreInfo)
        try container.encode(colorPattern, forKey: .colorPattern)
        
    }
    
    func loadPreviousSave(){
//        let hasBeenSavedBefore = UserStoarage.defaults.bool(forKey: id + UserStoarage.keys.hasIdBeenSavedBefore)
//        if(hasBeenSavedBefore){
//            self.title = UserStoarage.defaults.string(forKey: id + UserStoarage.keys.nameSave) ?? ""
//            self.moreInfo = UserStoarage.defaults.string(forKey: id + UserStoarage.keys.moreInfoSave) ?? ""
//            self.colorPattern = UserStoarage.defaults.string(forKey: id + UserStoarage.keys.colorPatternName) ?? ""
//            loadAllTomatos()
//        }else{
//            saveCurrentSave()
//        }
    }
    func saveCurrentSave(){
//        UserStoarage.defaults.set(true, forKey: id + UserStoarage.keys.hasIdBeenSavedBefore)
//        UserStoarage.defaults.set(title, forKey: id + UserStoarage.keys.nameSave)
//        UserStoarage.defaults.set(moreInfo, forKey: id + UserStoarage.keys.moreInfoSave)
//        UserStoarage.defaults.set(colorPattern, forKey: id + UserStoarage.keys.colorPatternName)
//        saveAllTomatos()
        UserStoarage.user().saveAll()
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
    func saveAllTomatos() {
//        let encoder = JSONEncoder()
//        UserStoarage.defaults.set(tasks.count, forKey: self.id+UserStoarage.keys.tomatosCount)
//
//        for index in 0..<tasks.count{
//            if (tasks[index] is Tomato) {//tomato case
//                let current :Tomato = tasks[index] as! Tomato
//                if let encoded = try? encoder.encode(current) {
//                    let defaults = UserDefaults.standard
//                    defaults.set(encoded, forKey: self.id+" "+String(index))
//                }
//            }else {//non tomato case
//                let current = (tasks[index] as! TaskHandler).id
//                (tasks[index] as! TaskHandler).saveCurrentSave()
//                if let encoded = try? encoder.encode(current) {
//                    let defaults = UserDefaults.standard
//                    defaults.set(encoded, forKey: self.id+" "+String(index))
//                }
//            }
//        }
    }
    
    func loadAllTomatos() {
//        tasks = []
//        let tomatoCount = UserStoarage.defaults.integer(forKey: self.id+UserStoarage.keys.tomatosCount)
//        for index in 0..<tomatoCount {
//            if let savedPerson = UserStoarage.defaults.object(forKey: self.id+" "+String(index)) as? Data {
//                let decoder = JSONDecoder()
//                if let loadedTomato = try? decoder.decode(Tomato.self, from: savedPerson) {
//                    tasks.append(loadedTomato)
//                }else if let loaded = try? decoder.decode(String.self, from: savedPerson) {
//                    let loadedTask = TaskHandler(loaded)
//                    tasks.append(loadedTask)
//                }
//            }
//        }
    }
    func addTask(_ task:TaskElement) {
        self.tasks.append(task)
        saveAllTomatos()
        if(self.title == "Archive") {
            print("added to archived file")
        }
        UserStoarage.user().saveAll()
    }
    func deleteAllTasks() {
        for x in tasks{
            if(x is TaskHandler){
                (x as! TaskHandler).deleteAllTasks()
            }
        }
        tasks.removeAll()
    }
}
