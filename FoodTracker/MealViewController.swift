//
//  MealViewController.swift
//  FoodTracker
//
//  Created by user124807 on 1/30/17.
//  Copyright © 2017 Darshan Nayak. All rights reserved.
//

import UIKit

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {    //These are the delegates for text field and image picker respectively
    
    
    //MARK: Properties
    
    
    @IBOutlet weak var nameTextField: UITextField!  //Outlet for Textbox
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    //Outlets are a way of setting/getting values from/to the objects on the canvas.
    
    
    override func viewDidLoad() {
        super.viewDidLoad() //predefined function, which basically invokes the viewDidLoad() of parent class.
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self   //sets the delegate of text field as this class (ViewController class).
    }

    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()    //here, we are resigning from the role of the textfield being the first responder, AKA, dismissing keypad
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //basic need of this method is to be able to read what the user typed in the keypad
        
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
    
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()    //dismissing keypad
        let imagePickerController = UIImagePickerController()   //creates a img picker
        imagePickerController.sourceType = .photoLibrary    //Only allow library photoes, not capture new ones!!
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil) //Presents the imagepicker to the user on screen
    }
    
    
}

