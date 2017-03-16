//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Richard Ju on 3/13/17.
//
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
    }
    
//    MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

//      Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
//    MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        Dismiss the picker ift he user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            
            fatalError("Expected a dictioanry containing an image, but was provided with the following: \(info)")
        }
        
//        Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
//        Dismiss the image picker.
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: Navigation
    // This method lets you configure a view controller before its presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
//    MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
//        Hide the Keyboard.
//        Ensures that if the image is tapped while the user typing in the text field, the keyboard is dismissed properly.
        nameTextField.resignFirstResponder()
        
//        UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
//        Only allow photos to be picked, not taken (sets the source/place where it can get images, .photoLibrary refers to Camera Roll)
        imagePickerController.sourceType = .photoLibrary
        
//        Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
//        ViewController presents the viewcontroller defined by imagePickerController, presentation is animated, no completion handler
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
}

