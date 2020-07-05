//
//  TaskDesignerViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-30.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class TaskDesignerViewController: UIViewController {
    /**
     used for creation and editing of tasks. should be called on the long click of a task.
     */
    let defaultTaskTitle = "Click To Add Task Name"
    let defaultTaskInfo = "Click To Add An Optional Task Description"
    
    
    var saveFunc: (_ saveableTask:TaskElement)->()
    var editingTask : TaskElement
    
    let tableView = UITableView()
    var viewElements: [UITableViewCell] = []
    var isTaskHandler = false
    
    init(_ editingTask:TaskElement,_ saveAction: @escaping (_ saveAbleTask : TaskElement)->()){
        print("TaskDesignViewControllerLoaded")
        isTaskHandler = editingTask is TaskHandler
        saveFunc = saveAction
        self.editingTask = editingTask
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupBarItems(self.view)
        setupTableItems(self.view)
        
    }
    let cellId = "A different reusable Id, but im running out of names"
    func setupTableItems(_ inputView : UIView){
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
        
        loadTableData()
        tableView.register(TaskElementCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .white
        
        print("table loaded")
    }
    var dataElements:[UITextField] = []//the data points
    func loadTableData(){
        /**
         heres where the different actual data/ UI for the cells is setup. Still Using the method of view cells array and data access array.
         */
        var cell:UITableViewCell = UITableViewCell()
        var tf = UITextField(frame: CGRect(x:30, y:5, width:320, height:20))
        tf.placeholder = defaultTaskTitle
        if  !(editingTask.title == "" || editingTask.title == defaultTaskTitle){
            tf.text = editingTask.title
            tf.textColor = .black
        }else{
            tf.textColor = .gray
        }
        tf.font = UIFont.systemFont(ofSize: 15)
        
        tf.backgroundColor = .white
        cell.backgroundColor = .white
        
        cell.addSubview(tf)
        dataElements.append(tf)
        viewElements.append(cell)
        
        //info needs to be a textView(i think) not a textField for multiple line input.
        
        cell = UITableViewCell()
        tf = UITextField(frame: CGRect(x:30, y:5, width:320, height:20))
        tf.placeholder = defaultTaskInfo
        if  !(editingTask.moreInfo == "" || editingTask.moreInfo == defaultTaskInfo){
            tf.text = editingTask.moreInfo
            tf.textColor = .black
        }else{
            tf.textColor = .gray
        }
        tf.backgroundColor = .white
        cell.backgroundColor = .white
        
        
        tf.font = UIFont.systemFont(ofSize: 15)
        cell.addSubview(tf)
        dataElements.append(tf)
        viewElements.append(cell)
        
        
        cell = UITableViewCell()
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(isTaskHandler, animated: true)
        switchView.tag = 2//hardcoding the second index of the array, big problem if i want to reorder it...
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        switchView.backgroundColor = .white
        cell.accessoryView = switchView
        cell.backgroundColor = .white
        viewElements.append(cell)
        
        
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        isTaskHandler = !(isTaskHandler)
    }
    func createTextInputCell(_ placeholder:String) -> UITableViewCell{
        let cell:UITableViewCell = UITableViewCell()
        let tf = UITextField(frame: CGRect(x:30, y:5, width:300, height:20))
        tf.placeholder = placeholder
        
        //This is a temporary fix, as a first step solution
        if(editingTask.title != placeholder && editingTask.moreInfo != placeholder){//this overrides the placeholder in all test cases, but it *does* solve the problem
            tf.text = placeholder
        }
        
        
        tf.font = UIFont.systemFont(ofSize: 15)
        
        cell.backgroundColor = .white
        tf.textColor = .black
        
        
        cell.addSubview(tf)
        dataElements.append(tf)
        return cell
    }
    
    
    
    
    func setupBarItems(_ view:UIView){
        let back = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backAction))
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        navigationItem.leftBarButtonItem = back
        navigationItem.rightBarButtonItem = save
    }
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction(){
        if(updateEditingHandler()){
            if((editingTask is TaskHandler) != isTaskHandler){//if state is switched
                if(editingTask is TaskHandler){
                    let newEditing:Tomato = Tomato(editingTask.title, editingTask.moreInfo)
                    (editingTask as! TaskHandler).deleteAllTasks()
                    editingTask = newEditing
                }else{
                    let id = String(Int.random(in: 0 ..< 1000))//TODO replace this with a better option! THIS WILL BREAK
                    let newEditing:TaskHandler = TaskHandler(id)
                    newEditing.title = editingTask.title
                    newEditing.moreInfo = editingTask.moreInfo
                    editingTask = newEditing
                }
            }
            
            
            saveFunc(editingTask)
            backAction()
        }else{
            print("error occured during save")
        }
    }
    
    func updateEditingHandler() -> Bool{
        /**
         returns true if saved properly. (eg, no error values)
         */
        //TODO get all info for the handler to be updated with
        let nameEntered = dataElements[0].text
        if(nameEntered == "" || nameEntered == defaultTaskTitle){//test for any and all edge cases here?
            return false
        }
        
        editingTask.title = nameEntered!
        
        let infoEntered = dataElements[1].text!//TODO this will cause errors for multy line entry
        editingTask.moreInfo = infoEntered
        
        return true
    }
}

extension TaskDesignerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print("getting cell")
        
        return viewElements[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
