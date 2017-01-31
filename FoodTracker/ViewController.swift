//
//  ViewController.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    //MARK: Properties
    
    
    @IBOutlet weak var nameTextField: UITextField!  //Outlet for Textbox
    @IBOutlet weak var mealNameLabel: UILabel!  //Outlet for Label.
    //Outlets are a way of setting/getting values from the objects on the canvas.
    
    
    override func viewDidLoad() {
        super.viewDidLoad() //predefined function, which basically invokes the viewDidLoad() of parent class.
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self   //sets the delegate of text field as this class (ViewController class).
    }

    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()    //here, we are resigning from the role of the textfield being the first responder.
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //basic need of this method is to be able to read what the user typed in the keypad
        mealNameLabel.text = textField.text //We just assigned text typed by the user in the textfield to the label!!
    }
    
    //MARK: Actions
    
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
}

