//
//  MealViewController.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//
/*
 This file is the Controller for the New Meal Scene in the Storyboard and is responsible for handling logic during Adding new meal or Updating existing meal.
 */
import UIKit
import os.log

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {    //These are the delegates for text field and image picker respectively
    
    
    //MARK: Properties
    
    
    @IBOutlet weak var nameTextField: UITextField!  //Outlet for Textbox
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    //Outl	ets are a way of setting/getting values from/to the objects on the canvas.
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad() //predefined function, which basically invokes the viewDidLoad() of parent class.
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self   //sets the delegate of text field as this class (ViewController class).
        
        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        

        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }

    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()    //here, we are resigning from the role of the textfield being the first responder, AKA, dismissing keypad
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //basic need of this method is to be able to read what the user typed in the keypad
        updateSaveButtonState()
        navigationItem.title = textField.text
        
    }
    
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)    //dismisses imgPicker on tapping cancel
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage    //Set selected image
        dismiss(animated: true, completion: nil)    //make the picker disappear after selecting image
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)    //This dismisses the modal scene, animates transition to previous scene
        }
            
            
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
            
            
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        

        

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Lets you configure a view controller before it is presented to the user
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? "" //Note this. It is a 'nil coalescing operator', returns a value if a value exists, else returns ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    
    
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()    //dismissing keypad
        let imagePickerController = UIImagePickerController()   //creates a img picker
        imagePickerController.sourceType = .photoLibrary    //Only allow library photoes, not capture new ones!!
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil) //Presents the imagepicker to the user on screen
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? "" //Note this. It is a 'nil coalescing operator', returns a value if a value exists, else returns ""
        saveButton.isEnabled = !text.isEmpty    //disable the Save button if the text field is empty
    }
}

