//
//  TaskEditorViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-28.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class TaskEditorViewController: UIViewController {
    /**
     display more info on the task, Long click from a taskHandler, and a short click from a tomato
     */
    //MARK: view variables
    var cellId = "controlCells"
    
    var safeArea = UILayoutGuide()
    let tableView = UITableView()
    var viewElements: [UITableViewCell] = []
    var dataElements: [UITextField] = []
    
    var resolvingAction: (_ task:TaskElement) -> ()
    var editingTask: TaskElement
    let defaultTaskTitle = "Click To Add Task Name"
    let defaultTaskInfo = "Click To Add An Optional Task Description"
    var isTaskHandler = false
    
    init(_ inputTask:TaskElement, _ resolvingAction: @escaping (_ task:TaskElement)->()) {
        self.resolvingAction = resolvingAction
        editingTask = inputTask
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //load function
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        print("view loaded")
        view.backgroundColor = UserStoarage.user().defaultColorPattern.backgrounColor
        
        setupTableView(self.view)
        setupSaveButton(self.view)
    }
    
    func setupSaveButton(_ inputView: UIView) {
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = save
    }
    
    @objc func saveButtonClicked(_ sender: UIButton) {
        if(updateEditingHandler()) {
            if((editingTask is TaskHandler) != isTaskHandler){//if state is switched
                if(editingTask is TaskHandler) {
                    let newEditing:Tomato = Tomato(editingTask.title, editingTask.moreInfo)
                    (editingTask as! TaskHandler).deleteAllTasks()
                    editingTask = newEditing
                }else {
                    let id = String(Int.random(in: 0 ..< 1000))//TODO replace this with a better option! THIS WILL BREAK
                    let newEditing:TaskHandler = TaskHandler(id)
                    newEditing.title = editingTask.title
                    newEditing.moreInfo = editingTask.moreInfo
                    editingTask = newEditing
                }
            }
            
            
            resolvingAction(editingTask)
        }else {
            print("error occured during save")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateEditingHandler() -> Bool {
        /**
         returns true if saved properly. (eg, no error values)
         */
        //TODO get all info for the handler to be updated with
        let nameEntered = dataElements[0].text
        if(nameEntered == "" || nameEntered == defaultTaskTitle) {//test for any and all edge cases here?
            return false
        }
        
        editingTask.title = nameEntered!
        
        let infoEntered = dataElements[1].text!//TODO this will cause errors for multy line entry
        editingTask.moreInfo = infoEntered
        
        return true
    }
    
    func setupTableView(_ inputView: UIView) {
        /**
         Setup the table
         */
        let view = inputView
        var safeArea  = UILayoutGuide()
        safeArea = view.layoutMarginsGuide
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        
        tableView.backgroundColor = UserStoarage.user().defaultColorPattern.backgrounColor
        
        
        loadTableData()
        tableView.register(TaskElementCell.self, forCellReuseIdentifier: cellId)
        
        print("table loaded")
    }
    
    func loadTableData() {
        /**
         heres where the different actual data/ UI for the cells is setup. Still Using the method of view cells array and data access array.
         */
        let userColorPattern = UserStoarage.user().defaultColorPattern
        var cell:UITableViewCell = UITableViewCell()
        var tf = UITextField(frame: CGRect(x:30, y:5, width:320, height:20))
        tf.placeholder = defaultTaskTitle
        if  !(editingTask.title == "" || editingTask.title == defaultTaskTitle){
            tf.text = editingTask.title
            tf.textColor = userColorPattern.mainTextColor
        }else{
            tf.textColor = userColorPattern.subTextColor
            print("else")
        }
        tf.font = UIFont.systemFont(ofSize: 15)
        
        tf.backgroundColor = userColorPattern.backgrounColor
        cell.backgroundColor = userColorPattern.backgrounColor
        
        cell.addSubview(tf)
        dataElements.append(tf)
        viewElements.append(cell)
        
        //info needs to be a textView(i think) not a textField for multiple line input.
        
        cell = UITableViewCell()
        tf = UITextField(frame: CGRect(x:30, y:5, width:320, height:20))
        tf.placeholder = defaultTaskInfo
        if  !(editingTask.moreInfo == "" || editingTask.moreInfo == defaultTaskInfo){
            tf.text = editingTask.moreInfo
            tf.textColor = userColorPattern.mainTextColor
        }else{
            tf.textColor = userColorPattern.subTextColor
        }
        tf.backgroundColor = userColorPattern.backgrounColor
        cell.backgroundColor = userColorPattern.backgrounColor
        
        
        tf.font = UIFont.systemFont(ofSize: 15)
        cell.addSubview(tf)
        dataElements.append(tf)
        viewElements.append(cell)
        
        
        cell = UITableViewCell()
        cell.textLabel?.text = "Make Task a ToDo List:"
        cell.textLabel?.textColor = userColorPattern.mainTextColor
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(isTaskHandler, animated: true)
        switchView.tag = 2//hardcoding the second index of the array, big problem if i want to reorder it...
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        switchView.backgroundColor = userColorPattern.backgrounColor
        cell.accessoryView = switchView
        cell.backgroundColor = userColorPattern.backgrounColor
        viewElements.append(cell)
    }
    
    @objc func switchChanged(_ sender : UISwitch!) {
        isTaskHandler = !(isTaskHandler)
    }
    
    
}






extension TaskEditorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return viewElements[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
