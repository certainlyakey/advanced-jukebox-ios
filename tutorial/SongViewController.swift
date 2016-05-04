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
//	@IBOutlet weak var songNameLabel: UILabel!
	

  
    @IBOutlet weak var VotesNumberLabel: UILabel!

	@IBOutlet weak var UILabelAlbum: UILabel!
	@IBOutlet weak var UILabelSong: UILabel!
	@IBOutlet weak var UILabelArtist: UILabel!
	
	@IBOutlet weak var photoImageView: UIImageView!


	//Code vars
	// Create a reference to a Firebase location
	var databaseRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")
	var currentId:Int = 0
	var currentVotes:Int = 0
	var currentIsVoted:Bool = false
	var currentImgURL:String = ""
	var song: Song?
	var songs = [Song]()
	var actSongID : Int = 0
	
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
	//	UILabelSong.delegate = self
		
		if let song = song {
			currentImgURL = song.imgurl!
			currentId = song.id!
			currentVotes = song.votes!
			currentIsVoted = song.voted!
			UILabelAlbum.text  = song.album
			UILabelSong.text = song.name
			UILabelArtist.text = song.artist
		}
		
		let url = NSURL(string: currentImgURL)
		
		
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
			
			if error != nil {
				print("thers an error in the log")
			} else {
				
				dispatch_async(dispatch_get_main_queue()) {
					let image = UIImage(data: data!)
					self.photoImageView.image = image
					
				}
			}
			
		}
		
		task.resume()

		VotesNumberLabel.text = String(currentVotes)
		
		let songsRef = databaseRef.childByAppendingPath("songs")
		songsRef.observeEventType(.Value, withBlock: { snapshot in
			self.songs = []
			for song_item in snapshot.value as! [AnyObject] {
				let song = Song(
					id: song_item["id"] as? Int,
					name: song_item["name"] as? String,
					imgurl: song_item["imgurl"] as? String,
					votes:song_item["votes"] as? Int,
					album: song_item["album"] as? String,
					artist: song_item["artist"] as? String,
					voted: song_item["voted"] as? Bool
					)!
				self.songs += [song]
			}
			//self.tableView.reloadData()
			}, withCancelBlock: { error in
				print(error.description)
		})
		
		
	}

	// fill the info for the database item
	@IBAction func fbAction(sender: UIButton) {
		let songinfo = [
			"id":currentId,
			"album":UILabelAlbum.text!,
			"name":UILabelSong.text!,
			"artist":UILabelArtist.text!,
			"voted":false,
			"votes":currentVotes,
			"imgurl":currentImgURL
		]
		let songRef = databaseRef.childByAppendingPath("song")
		// Write data to Firebase
		songRef.setValue(songinfo)
		
		let songsRef = databaseRef.childByAppendingPath("songs")
		let actSongRef = songsRef.childByAppendingPath(String(currentId))
		let actVotes = ["votes": currentVotes]
		
		actSongRef.updateChildValues(actVotes)
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
		// nameTextField.resignFirstResponder() //hide keyboard
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .PhotoLibrary
		
		// Make sure ViewController is notified when the user picks an image
		imagePickerController.delegate = self
		presentViewController(imagePickerController, animated: true, completion: nil)
	}

	@IBAction func VoteButton(sender: UIButton) {
		currentVotes = currentVotes + 1
		VotesNumberLabel.text = String(currentVotes)
		
		let songsRef = databaseRef.childByAppendingPath("songs")
		let actSongRef = songsRef.childByAppendingPath(String(currentId))
		let actVotes = ["votes": currentVotes]
		
		actSongRef.updateChildValues(actVotes)
	}

    @IBAction func LeftButton1(sender: UIButton) {
        if (actSongID > 0)
        {
			songs.sortInPlace ({$0.votes > $1.votes})
            actSongID = actSongID - 1
            song = songs[actSongID]
            viewDidLoad()
        }
    }
    
    @IBAction func RightButton1(sender: UIButton) {
        if (actSongID < songs.count - 1)
        {
            songs.sortInPlace ({$0.votes > $1.votes})
            actSongID = actSongID + 1
            song = songs[actSongID]
            viewDidLoad()
        }
    
    }
    
    
	/*@IBAction func LeftButton(sender: UIButton) {
		if (actSongID > 0)
		{
			actSongID = actSongID - 1
			song = songs[actSongID]
			//viewDidLoad()
		}
	}*/
	
/*	@IBAction func setDefaultLabelText(sender: UIButton) {
		songNameLabel.text = "Added!"
	}
	// MARK: UITextFieldDelegate
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		// Hide the keyboard
		textField.resignFirstResponder()
		return true
	}*/
	
}

