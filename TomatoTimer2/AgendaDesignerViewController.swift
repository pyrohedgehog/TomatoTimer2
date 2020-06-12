//
//  AgendaDesignerViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-06-02.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class AgendaDesignerViewController: UIViewController {
    let blankAgendaTitle = "Click To Add An Agenda Name"
    let blankAgendaInfo = "Click To Add An Optional Agenda Description"
    
    
    var saveFunc: (_ saveableHandler:TomatoHandler)->()
    var editingHandler : TomatoHandler
    
    let tableView = UITableView()
    var viewElements: [UITableViewCell] = []
    
    init(_ editingHandler:TomatoHandler,_ saveAction: @escaping (_ saveableHandler : TomatoHandler)->()){
        saveFunc = saveAction
        self.editingHandler = editingHandler
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
        tableView.register(TomatoCell.self, forCellReuseIdentifier: cellId)
        
        print("table loaded")
    }
    var dataElements:[UITextField] = []//the point
    func loadTableData(){
        /**
         heres where the different actual data/ UI for the cells is setup. Still Using the method of view cells array and data access array.
         */
        var cell:UITableViewCell = UITableViewCell()
        var tf = UITextField(frame: CGRect(x:30, y:5, width:320, height:20))
        tf.placeholder = blankAgendaTitle
        if  !(editingHandler.name == "" || editingHandler.name == blankAgendaTitle){
            tf.text = editingHandler.name
        }
        tf.font = UIFont.systemFont(ofSize: 15)
        cell.addSubview(tf)
        dataElements.append(tf)
        viewElements.append(cell)
        
        //info needs to be a textView(i think) not a textField for multiple line input.
        
        cell = UITableViewCell()
        tf = UITextField(frame: CGRect(x:30, y:5, width:320, height:20))
        tf.placeholder = blankAgendaInfo
        if  !(editingHandler.moreInfo == "" || editingHandler.moreInfo == blankAgendaInfo){
            tf.text = editingHandler.moreInfo
        }
        tf.font = UIFont.systemFont(ofSize: 15)
        cell.addSubview(tf)
        dataElements.append(tf)
        viewElements.append(cell)
        
    }
    func createTextInputCell(_ placeholder:String) -> UITableViewCell{
        let cell:UITableViewCell = UITableViewCell()
        let tf = UITextField(frame: CGRect(x:30, y:5, width:300, height:20))
        tf.placeholder = placeholder
        
        //This is a temporary fix, as a first step solution
        if(Tomato().name != placeholder || Tomato().description != placeholder){//this overrides the placeholder in all test cases, but it *does* solve the problem
            tf.text = placeholder
        }
        
        
        tf.font = UIFont.systemFont(ofSize: 15)
        
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
            editingHandler.saveCurrentSave()
            saveFunc(editingHandler)
            backAction()
        }//else{
            //Throw Error somehow
        //}
    }
    
    func updateEditingHandler() -> Bool{
        /**
         returns true if saved properly. (eg, no error values)
         */
        //TODO get all info for the handler to be updated with
        let nameEntered = dataElements[0].text
        if(nameEntered == "" || nameEntered == blankAgendaTitle){//test for any and all edge cases here?
            return false
        }
        
        editingHandler.name = nameEntered!
        
        let infoEntered = dataElements[1].text!//TODO this will cause errors for multy line entry
        editingHandler.moreInfo = infoEntered
        
        return true
    }
}

extension AgendaDesignerViewController: UITableViewDataSource, UITableViewDelegate {
    
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


