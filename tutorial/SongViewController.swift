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
	//Temp UI vars


	//UI vars
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var songNameLabel: UILabel!
	@IBOutlet weak var addButton: UIButton!
	
	@IBOutlet weak var VotesNumberLabel: UILabel!

	@IBOutlet weak var UILabelAlbum: UILabel!
	@IBOutlet weak var UILabelSong: UILabel!
	@IBOutlet weak var UILabelArtist: UILabel!
	
	@IBOutlet weak var photoImageView: UIImageView!

	@IBOutlet weak var fbLabel: UILabel!


	//Code vars
	// Create a reference to a Firebase location
	var databaseRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")
	var currentId:Int = 0
	var currentVotes:Int = 0
	var currentIsVoted:Bool = false
	var song: Song?
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Handle the text field’s user input through delegate callbacks.
		//nameTextField.delegate = self
		
		if let song = song {
			currentId = song.id
			currentVotes = song.votes
			currentIsVoted = song.voted!
			UILabelAlbum.text  = song.album
			UILabelSong.text = song.name
			UILabelArtist.text = song.artist
			photoImageView.image = song.photo
		}
		
	}

	// fill the info for the database item
	@IBAction func fbAction(sender: UIButton) {
		let songinfo = [
			"id":currentId,
			"album":UILabelAlbum.text!,
			"name":UILabelSong.text!,
			"artist":UILabelArtist.text!,
			"voted":false,
			"votes":currentVotes
		]
		let songRef = databaseRef.childByAppendingPath("song")
		// Write data to Firebase
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

	@IBAction func VoteButton(sender: UIButton) {
		currentVotes = currentVotes + 1
		VotesNumberLabel.text = String(currentVotes)
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

