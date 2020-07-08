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
    public static var archive:TaskHandler = TaskHandler("Archive")
    init(){
        StartScreenViewController.archive.title = "Archive"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let mainPage = TaskHandler("MainPage")
        mainPage.title = "Home Page"
        mainPage.moreInfo = "   "
        
        let defaults = UserDefaults.standard
        let previouslyLoaded = defaults.bool(forKey: "hasAppPreviouslyBeenLaunched")//could be done by checking MainPage's existance, but this is more clear
        if(previouslyLoaded==false){
            mainPage.title = "Home Page"
            mainPage.addTask(StartScreenViewController.archive)
            StartScreenViewController.archive.saveCurrentSave()
            
            let tutorial = TaskHandler("Tutorial")
            tutorial.makeTutorial()
            mainPage.addTask(tutorial)
            defaults.set(true, forKey: "hasAppPreviouslyBeenLaunched")
        }
        
        let view = ItemDisplayViewController(mainPage,StartScreenViewController.archive)
        navigationController?.setViewControllers([view], animated: true)
    }
}
