//
//  EditTomatoViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-05-09.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class EditTomatoViewController: UIViewController {
    var name : UITextField = UITextField();
    var info : UITextView = UITextView();
    var nameText = "Click To Enter Title"
    var infoText = "Click To Enter Description"
    var saveButton = UIButton()
    var tomato : Tomato;
    
    init(_ tomato: Tomato){
        self.tomato = tomato
        self.nameText = tomato.name
        self.infoText = tomato.description//really inconsistant naming, needs to be fixed.
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupTextInputs()
        setupCreateButton()
        
        
        print("creation view loaded")
    }
    func setupTextInputs(){
        let width = 360
        //name setup
        name.delegate = self as? UITextFieldDelegate
        name = UITextField(frame: CGRect(x: 20, y: 100, width: width, height: 40))
//        name.placeholder = nameText
        name.text = nameText
        name.font = UIFont.systemFont(ofSize: 18)
        name.borderStyle = UITextField.BorderStyle.line
        name.autocorrectionType = UITextAutocorrectionType.yes
        name.keyboardType = UIKeyboardType.default
        name.returnKeyType = UIReturnKeyType.done//return for multiple lines
        name.clearButtonMode = UITextField.ViewMode.whileEditing
        name.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.view.addSubview(name)
        
        //info setup
        info = UITextView(frame: CGRect(x: 20, y: 150, width: width, height: 200))
        info.delegate = self as? UITextViewDelegate
        
        info.text = infoText
        info.textColor = UIColor.lightGray
        info.font = UIFont.systemFont(ofSize: 15)
        info.layer.borderColor = UIColor.black.cgColor
        info.layer.borderWidth = 1.0
        
        
        
        self.view.addSubview(info)
}
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = infoText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func setupCreateButton(){
        let width = 100, height = 50
        saveButton = UIButton(frame: CGRect(x: 150, y: 600, width: width, height: height))
        saveButton.backgroundColor = .green
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        self.view.addSubview(saveButton)
    }
        
        
    @objc func saveButtonClicked(sender: UIButton!){
        tomato.name =  (name.text == nil || name.text!.isEmpty) ? "": name.text!
        
        tomato.description = info.text
        print("saved!")
    }

    

}
