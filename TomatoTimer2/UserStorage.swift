//
//  UserStorage.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-07-06.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
class UserStoarage {
    /**
     a class to store and handle all user data, this is the class to store everything that this user consists of. If files are to be shared off site, this would be the file to do so.
     */
    //also if i want to collect user data (for things like optomization) it will appear here.
    private static var setupUser: UserStoarage = {
        let user = UserStoarage()
        //if you need to configure the user before initializing, do it here.
        
        return user
    }()
    
    var mainAgenda: TaskHandler
    var mainArchive: TaskHandler
    var defaultColorPattern: ColorPattern
    private init() {
        mainAgenda = TaskHandler("MainPage")
        mainArchive = TaskHandler("Archive")
        mainArchive.title = "Archive"
        defaultColorPattern = ColorPattern.getColor("light")
    }
    static let defaults = UserDefaults.standard
    struct keys{
        /**
         standard key storage for user defaults keys.
         */
        static let names            = "handlerIDS"
        static let previouslyLoaded = "hasAppPreviouslyBeenLaunched"
        static let tomatosCount             = " NumberOfTomatos"
        static let hasIdBeenSavedBefore     = "Has id been used or saved before"
        static let nameSave                 = "Name Save point"
        static let moreInfoSave             = "More Info Save Point"
        static let colorPatternName         = " ColorPattern"
    }
    
    private func loadFromSave(){
        
    }
    
    class func user() -> UserStoarage {
        return setupUser
    }
    
}
