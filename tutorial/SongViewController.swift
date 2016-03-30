//
//  SongViewController.swift
//  tutorial
//
//  Created by AleksandrBeliaev on 02/03/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit
import Firebase

class SongViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var songNameLabel: UILabel!
	@IBOutlet weak var addButton: UIButton!
    
	
	@IBOutlet weak var ratingControl: RatingControl!
	@IBOutlet weak var photoImageView: UIImageView!

    @IBOutlet weak var fbLabel: UILabel!
    // Create a reference to a Firebase location
    var myRootRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")
    // Write data to Firebase
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }
	
	@IBAction func fbAction(sender: UIButton) {
		var songinfo = ["album":"IOS!","name":"Money Money Money from iOS","artist":"Rottelini"]
		var songRef = myRootRef.childByAppendingPath("song")
		songRef.setValue(songinfo)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		photoImageView.image = selectedImage
		dismissViewControllerAnimated(true, completion: nil)
	}
	
    // MARK: Actions
	@IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
		nameTextField.resignFirstResponder() //hide keyboard
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .PhotoLibrary
		
		// Make sure ViewController is notified when the user picks an image
		imagePickerController.delegate = self
		presentViewController(imagePickerController, animated: true, completion: nil)
	}
    
    @IBAction func setDefaultLabelText(sender: UIButton) {
        songNameLabel.text = "Added!"
    }
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
		let buttonText = textField.text
        songNameLabel.text = "Found!"
		addButton.setTitle("Add song "+buttonText!+"?", forState: .Normal)
    }

}

