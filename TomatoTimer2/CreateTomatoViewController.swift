//
//  CreateTomatoViewController.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-04-19.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//

import UIKit

class CreateTomatoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var name : UITextField = UITextField();
    var info : UITextView = UITextView();
    var nameText = "Click To Enter Title"
    var infoText = "Click To Enter Description"
    var createButton = UIButton()
    
    //MVP Tomato Created!
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
        name.delegate = self
        name = UITextField(frame: CGRect(x: 20, y: 100, width: width, height: 40))
        name.placeholder = nameText
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
        info.delegate = self

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
        createButton = UIButton(frame: CGRect(x: 150, y: 600, width: width, height: height))
        createButton.backgroundColor = .green
        createButton.setTitle("Create", for: .normal)
        createButton.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
        self.view.addSubview(createButton)
    }
    
    
    @objc func createButtonClicked(sender: UIButton!){
        
    }

}
