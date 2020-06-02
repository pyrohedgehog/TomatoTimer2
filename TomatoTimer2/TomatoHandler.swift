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
    var name:String
    var tomatos:[Tomato]
    init(_ name : String){
        self.name = name
        self.tomatos = []
    }
    func makeTutorial(){
        /**
         makes the tutorial TomatoHandler. Only call if its the first time the user makes an "account"
         */
        self.tomatos = [Tomato("Hello"),Tomato("world")]
    }
    let defaults = UserDefaults.standard
    struct keys{
        static let tomatosCount = " NumberOfTomatos"
    }
    
    //TODO: this will cause errors if user has multiple agendas with the same name...
    func saveAllTomatos(){
        let encoder = JSONEncoder()
        defaults.set(tomatos.count, forKey: self.name+keys.tomatosCount)
        
        for index in 0..<tomatos.count{
            if let encoded = try? encoder.encode(tomatos[index]) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: name+" "+String(index))
            }
        }
    }
    
    func loadAllTomatos(){
        print("loading all tomatos")
        let tomatoCount = defaults.integer(forKey: self.name+keys.tomatosCount)
        for index in 0..<tomatoCount{
            if let savedPerson = defaults.object(forKey: name+" "+String(index)) as? Data {
                let decoder = JSONDecoder()
                if let loadedTomato = try? decoder.decode(Tomato.self, from: savedPerson) {
                    tomatos.append(loadedTomato)
                    print("tomato # "+String(index)+" has been loaded")
                }
            }
        }
    }
    
    
    
    
}
