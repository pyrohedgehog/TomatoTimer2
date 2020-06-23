//
//  TomatoHandler.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-01.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
class TomatoHandler{
    /**
     The class for handling all the tomatos in a single agenda.
     */
    var name    : String = ""
    var id      : String
    var tomatos : [Tomato]
    var moreInfo : String = ""
    init(_ id : String){
        self.tomatos = []
        self.id = id
        loadPreviousSave()
    }
    func loadPreviousSave(){
        let hasBeenSavedBefore = defaults.bool(forKey: id + keys.hasIdBeenSavedBefore)
        if(hasBeenSavedBefore){
            self.name = defaults.string(forKey: id + keys.nameSave)!//not angry coding, if it has been saved than it MUST have a name
            self.moreInfo = defaults.string(forKey: id + keys.moreInfoSave) ?? ""
            loadAllTomatos()
        }else{
            saveCurrentSave()
        }
    }
    func saveCurrentSave(){
        if (name == ""){
            name = "Click to define Name"
        }
        defaults.set(true, forKey: id + keys.hasIdBeenSavedBefore)
        defaults.set(name, forKey: id + keys.nameSave)
        defaults.set(moreInfo, forKey: id + keys.moreInfoSave)
        saveAllTomatos()
    }
    
    func makeTutorial(){
        /**
         makes the tutorial TomatoHandler. Only call if its the first time the user makes an "account"
         */
        self.tomatos = [Tomato("Hello"),Tomato("world")]
        self.name = "Tutorial"
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
        defaults.set(tomatos.count, forKey: self.id+keys.tomatosCount)
        
        for index in 0..<tomatos.count{
            if let encoded = try? encoder.encode(tomatos[index]) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: self.id+" "+String(index))
            }
        }
    }
    
    func loadAllTomatos(){
        print("loading all tomatos")
        tomatos = []
        let tomatoCount = defaults.integer(forKey: self.id+keys.tomatosCount)
        for index in 0..<tomatoCount{
            if let savedPerson = defaults.object(forKey: self.id+" "+String(index)) as? Data {
                let decoder = JSONDecoder()
                if let loadedTomato = try? decoder.decode(Tomato.self, from: savedPerson) {
                    tomatos.append(loadedTomato)
                    print("tomato # "+String(index)+" has been loaded")
                }
            }
        }
    }
    
    
    func addTomato(_ tomato:Tomato){
        //additional information such as time added set here
        self.tomatos.append(tomato)
        if(self.id == "Archive"){
            print("added to archived file")
        }
        saveAllTomatos()
        
    }
    
    
    
    
}
