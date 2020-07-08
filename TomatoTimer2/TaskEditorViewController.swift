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
    var textFieldElements: [UITextField] = []
    
    var resolvingAction: (_ task:TaskElement) -> ()
    var editingTask: TaskElement
    
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
        view.backgroundColor = .white //set it to the color that you prefer
        
        setupTableView(self.view)
        setupSaveButton(self.view)
    }
    
    func setupSaveButton(_ inputView: UIView){
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = save
        print("save button loaded")
    }
    
    @objc func saveButtonClicked(_ sender: UIButton){
        //Best way i can think of to solve this at the moment, will cause errors if order is changed. (However this is a static order)
        editingTask.title = (textFieldElements[0].text == nil || textFieldElements[0].text!.isEmpty) ? "": textFieldElements[0].text!
        editingTask.moreInfo = (textFieldElements[1].text == nil || textFieldElements[1].text!.isEmpty) ? "": textFieldElements[1].text!
        resolvingAction(editingTask)
        print("save button clicked")
        //TODO make sure item is not blank
        self.navigationController?.popViewController(animated: true)
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
        
        tableView.backgroundColor = .white
        
        loadTableData()
        tableView.register(TaskElementCell.self, forCellReuseIdentifier: cellId)
        
        print("table loaded")
    }
    
    func loadTableData() {
        //setup UI table cells here
        viewElements.append(createTextInputCell(editingTask.title))
        viewElements.append(createTextInputCell(editingTask.moreInfo))
    }
    
    func createTextInputCell(_ placeholder:String) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        let tf = UITextField(frame: CGRect(x:30, y:5, width:300, height:20))
        tf.placeholder = placeholder
        
        //This is a temporary fix, as a first step solution
        if(Tomato("").title != placeholder || Tomato("").moreInfo != placeholder){//this overrides the placeholder in all test cases, but it *does* solve the problem
            tf.text = placeholder
        }
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.textColor = .black
        tf.backgroundColor = .white
        cell.addSubview(tf)
        textFieldElements.append(tf)
        cell.backgroundColor = .white
        return cell
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
