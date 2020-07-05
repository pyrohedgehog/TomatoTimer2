////
////  TomatoDesignerViewController.swift
////  TomatoTimer2
////
////  Created by jonah wilmsmeyer on 2020-05-20.
////  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
////
//
//import UIKit
//
//class TomatoDesignerViewController: UIViewController{
//    //MARK: view variables
//    var cellId = "controlCells"
//    
//    var safeArea = UILayoutGuide()
//    let tableView = UITableView() 
//    var viewElements : [UITableViewCell] = []
//    var textFieldElements : [UITextField] = []
//    
//    var resolvingAction:(_ tomato:Tomato)->()
//    var editingTomato :Tomato
//    
//    init(_ inputTomato:Tomato, _ resolvingAction: @escaping (_ tomato:Tomato)->()){
//        self.resolvingAction = resolvingAction
//        editingTomato = inputTomato
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    
//    //load function
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        safeArea = view.layoutMarginsGuide
//        print("view loaded")
//        view.backgroundColor = .white //set it to the color that you prefer
//        
//        
//        
//        setupTableView(self.view)
//        setupSaveButton(self.view)
//        tableView.backgroundColor = .white
//    }
//    func setupSaveButton(_ inputView: UIView){
//        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
//        navigationItem.rightBarButtonItem = save
//        print("save button loaded")
//    }
//    @objc func saveButtonClicked(_ sender: UIButton){
//        
//        
//        
//        //Best way i can think of to solve this at the moment, will cause errors if order is changed. (However this is a static order)
//        editingTomato.title = (textFieldElements[0].text == nil || textFieldElements[0].text!.isEmpty) ? "": textFieldElements[0].text!
//        editingTomato.moreInfo = (textFieldElements[1].text == nil || textFieldElements[1].text!.isEmpty) ? "": textFieldElements[1].text!
//        resolvingAction(editingTomato)
//        print("save button clicked")
//        //TODO fix multiple creations on save, (exit on save)
//        //TODO make sure item is not blank
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//    func setupTableView(_ inputView: UIView){
//        /**
//         Setup the table
//         */
//        let view = inputView
//        var safeArea  = UILayoutGuide()
//        safeArea = view.layoutMarginsGuide
//        tableView.delegate = self
//        tableView.dataSource = self
//        view.addSubview(self.tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
//        
//        loadTableData()
//        tableView.register(TaskElementCell.self, forCellReuseIdentifier: cellId)
//        
//        print("table loaded")
//    }
//    
//    
//    
//    func loadTableData(){
//        //setup UI table cells here
//        viewElements.append(createTextInputCell(editingTomato.title))
//        viewElements.append(createTextInputCell(editingTomato.moreInfo))
//    }
//    
//    func createTextInputCell(_ placeholder:String) -> UITableViewCell{
//        let cell:UITableViewCell = UITableViewCell()
//        let tf = UITextField(frame: CGRect(x:30, y:5, width:300, height:20))
//        tf.placeholder = placeholder
//        
//        //This is a temporary fix, as a first step solution
//        if(Tomato("").title != placeholder || Tomato("").moreInfo != placeholder){//this overrides the placeholder in all test cases, but it *does* solve the problem
//            tf.text = placeholder
//            tf.textColor = .black
//        }
//        
//        tf.backgroundColor = .white
//        tf.font = UIFont.systemFont(ofSize: 15)
//        cell.backgroundColor = .white
//        cell.addSubview(tf)
//        textFieldElements.append(tf)
//        return cell
//    }
//    
//    
//}
//
//
//
//
//
//
//extension TomatoDesignerViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewElements.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //        print("getting cell")
//        
//        return viewElements[indexPath.row]
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//    
//   
//}
//
