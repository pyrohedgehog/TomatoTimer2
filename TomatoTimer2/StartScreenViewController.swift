//
//  StartScreenViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-28.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    /**
     welcome the user, login if required, then launch the home task
     */
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let mainPage = UserStoarage.user().mainAgenda
        mainPage.title = ""
        mainPage.moreInfo = ""
        
        let defaults = UserDefaults.standard
        var previouslyLoaded = defaults.bool(forKey: UserStoarage.keys.previouslyLoaded )//TODO: Replace this with a cloud check for a main page
        
//        previouslyLoaded = false//TODO: Remember this is only for ease of testing
        
        if(previouslyLoaded == false){
            mainPage.addTask(UserStoarage.user().mainArchive)
            UserStoarage.user().mainArchive.saveCurrentSave()
            
            let tutorial = TaskHandler("Tutorial")
            tutorial.makeTutorial()
            mainPage.addTask(tutorial)
            defaults.set(true, forKey: "hasAppPreviouslyBeenLaunched")
            UserStoarage.user().saveAll()
        } else {
            UserStoarage.user().loadFromSave()
        }
        
        do {
            sleep(4)
        }
        print("loading main view now!")
        let view = ItemDisplayViewController(UserStoarage.user().mainAgenda, UserStoarage.user().mainArchive)
        view.tableView.reloadData()
        navigationController?.setViewControllers([view], animated: true)
        view.tableView.reloadData()
    }
}
