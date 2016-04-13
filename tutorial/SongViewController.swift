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
    
	@IBOutlet weak var VotesNumberLabel: UILabel!
	
	var VotesNumber:Int = 0
	@IBAction func VoteButton(sender: UIButton) {
		VotesNumber = VotesNumber + 1
		VotesNumberLabel.text = String(VotesNumber)
	}

	@IBOutlet weak var UILabelAlbum: UILabel!
	@IBOutlet weak var UILabelSong: UILabel!
	@IBOutlet weak var UILabelArtist: UILabel!
	
	@IBOutlet weak var ratingControl: RatingControl!
	@IBOutlet weak var photoImageView: UIImageView!

    @IBOutlet weak var fbLabel: UILabel!
    // Create a reference to a Firebase location
    var myRootRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")
    // Write data to Firebase
	

	var song: Song?
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Handle the text field’s user input through delegate callbacks.
		//nameTextField.delegate = self
		
		// Set up views if editing an existing Meal.
		if let song = song {
		//	navigationItem.title = song.name
			UILabelAlbum.text  = song.album
			UILabelSong.text = song.name
			UILabelArtist.text = song.artist
			photoImageView.image = song.photo
		}
		
		// Enable the Save button only if the text field has a valid Meal name.
		//checkValidMealName()
	}
	
	@IBAction func fbAction(sender: UIButton) {
		//var songinfo = ["album":"test album","name":"test song","artist":"test artist"]
		var songinfo = ["album":UILabelAlbum.text!,"name":UILabelSong.text!,"artist":UILabelArtist.text!]
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

