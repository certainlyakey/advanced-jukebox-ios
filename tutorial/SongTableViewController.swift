//
//  SongTableViewController.swift
//  tutorial
//
//  Created by AleksandrBeliaev on 17/03/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
	
	var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
		loadSampleSongs()
    }
	


	func loadSampleSongs() {
		
		let photo1 = UIImage(named: "dd1")!
		
		let song1 = Song(name: "I have been loved by you", photo: photo1, rating: 4)!
		
		let photo2 = UIImage(named: "dd2")!
		let song2 = Song(name: "A ya syadu v kabriolet", photo: photo2, rating: 5)!
		
		let photo3 = UIImage(named: "dd3")!
		let song3 = Song(name: "Singing Pugs Make It Again", photo: photo3, rating: 3)!
		
		songs += [song1, song2, song3]
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

		return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
        return songs.count
    }

	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		// Table view cells are reused and should be dequeued using a cell identifier.
		let cellIdentifier = "SongTableViewCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SongTableViewCell
		
		let song = songs[indexPath.row]
		
		cell.name.text = song.name
		cell.photoImageView.image = song.photo
		cell.ratingControl.rating = song.rating
		
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		if segue.identifier == "ShowDetail" {
			let songDetailViewController = segue.destinationViewController as! SongViewController
			
			// Get the cell that generated this segue.
			if let selectedSongCell = sender as? SongTableViewCell {
				let indexPath = tableView.indexPathForCell(selectedSongCell)!
				let selectedSong = songs[indexPath.row]
				songDetailViewController.song = selectedSong
			}
//		}
//		else if segue.identifier == "AddItem" {
//			print("Adding new meal.")
//		}
	}
	

}
