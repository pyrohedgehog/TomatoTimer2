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
    }
    
    
    enum CodingKeys: CodingKey {
        case title, tasks, moreInfo, colorPattern, taskCount
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        let tasksStrings = try container.decode([String].self, forKey: .tasks)
//        print(tasksStrings)//Only for debugging
        let jsonDecoder = JSONDecoder()
        
        tasks = []
        let sampleTomato: TaskElement = Tomato("This is not the tomato you are looking for")
        for x in tasksStrings{
//            print(x)
            
            var newTask: TaskElement = sampleTomato
            
            if(x.contains("\"tasks\"")){//IS TASK HANDLER
                
                newTask = try jsonDecoder.decode(TaskHandler.self, from: x.data(using: .utf8)!)
            }else if(x.contains("\"title\"")){
                newTask = try jsonDecoder.decode(Tomato.self, from: x.data(using: .utf8)!)
            }
            if(newTask !== sampleTomato){//kinda clumbsy, but something about this code makes me smile when i see it
                tasks.append(newTask)
            }

        }
        
        super.init()
        
        moreInfo = try container.decode(String.self, forKey: .moreInfo)
        title = try container.decode(String.self, forKey: .title)
        self.colorPattern = try container.decode(String.self, forKey: .colorPattern)
    }
    
    
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
//        try container.encode(tasks.count, forKey: .taskCount)
        
        var tasksStrings = [""]
        //encode as an array of strings for each tasks, then decode the whole array
        let secondEncoder = JSONEncoder()
        secondEncoder.outputFormatting = .prettyPrinted
        for x in tasks{
            tasksStrings.append(String(data:try secondEncoder.encode(x),encoding: .utf8)!)
        }
//        tasksString = String(data:try secondEncoder.encode(tasks),encoding: .utf8)!
        
        
        try container.encode(tasksStrings, forKey: .tasks)//TODO:fix encoding structure
        
        
        try container.encode(moreInfo, forKey: .moreInfo)
        try container.encode(colorPattern, forKey: .colorPattern)
        
    }
    func saveCurrentSave(){
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
    
    func saveAllTomatos() {
        UserStoarage.user().saveAll()
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
