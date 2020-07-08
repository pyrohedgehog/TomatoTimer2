//
//  UserStorage.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-07-06.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import Foundation
class UserStoarage{
    /**
     a class to store and handle all user data, this is the class to store everything that this user consists of. If files are to be shared off site, this would be the file to do so.
     */
    //also if i want to collect user data (for things like optomization) it will appear here.
    var mainAgenda : TaskHandler
    init(){
        mainAgenda = TaskHandler("MainPage")
    }
    
}
