//
//  UserStorage.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-07-06.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import CloudKit
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
        

//        self.loadFromSave()
    }
    
    

    
    
    static let defaults = UserDefaults.standard
    struct keys {
        /**
         standard key storage for user defaults keys.
         */
        static let names                    = "handlerIDS"
        static let previouslyLoaded         = "hasAppPreviouslyBeenLaunched"
        static let tomatosCount             = " NumberOfTomatos"
        static let hasIdBeenSavedBefore     = "Has id been used or saved before"
        static let nameSave                 = "Name Save point"
        static let moreInfoSave             = "More Info Save Point"
        static let colorPatternName         = " ColorPattern"
        static let cloudStorageName         = "UserStorage"//SHOULD BE "UserStorage"
        static let cloudMainAgendaName      = "MainAgenda"
    }
    
    let defaultContainer = CKContainer.default()
    func loadFromSave() {
        print("load from save called")
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: keys.cloudStorageName, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 1
        
        operation.recordFetchedBlock = { record in
            print("record functions being run")
            let x: Data = (record[keys.cloudMainAgendaName] as! String).data(using: .utf8)!
            do{
                self.mainAgenda = try JSONDecoder().decode(TaskHandler.self, from: x)
                print("IT WORKED!!! LIKE< WORKED WORKED!!!")
            } catch {
                print("error recording from database")
            }
        }
        
        
        operation.queryCompletionBlock = { cursor, error in
            DispatchQueue.main.async {
                print("completion block ran")
//                print("Titles: \(titles)")
//                print("RecordIDs: \(recordIDs)")
            }
        }
        defaultContainer.privateCloudDatabase.add(operation)
    }
    
//    private func fetchUserRecord(recordID: CKRecord.ID) {
//        // Fetch Private Database
//        let privateDatabase = defaultContainer.privateCloudDatabase
//
//        // Fetch User Record
//        privateDatabase.fetch(withRecordID: recordID) { (record, error) -> Void in
//            if let responseError = error {
//                print(responseError)
//                print("this was the error")
//
//            } else if let userRecord = record{
//                print(userRecord)
//                print("THIS IS USER RECORD")
//            }
//        }
//    }
    
    class func user() -> UserStoarage {
        return setupUser
    }
    
    func convertMainAgendaToJSON() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(self.mainAgenda)
        
//        print(String(data: data, encoding: .utf8)!)
        
        return(String(data: data, encoding: .utf8)!)
    }
    
    func saveAll() {
        /**
         a save function for storing all tomatos to the icloud storage system. Saves all tasks under the invisable homePage
         */
        doSubmission()
    }
    func doSubmission() {
        let agendaRecord = CKRecord(recordType: keys.cloudStorageName)
        agendaRecord[keys.cloudMainAgendaName] = convertMainAgendaToJSON() as CKRecordValue
        defaultContainer.privateCloudDatabase.save(agendaRecord, completionHandler:  { [unowned self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    let foo = "Error: \(error.localizedDescription)"
                    print(foo)
                } else {
                    print("UPLOADED!!!")
                }
            }
        })
//        loadAll()
        
        
    }
    
}
