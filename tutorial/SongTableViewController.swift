//
//  SongTableViewController.swift
//  tutorial
//
//  Created by AleksandrBeliaev on 17/03/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit
import Firebase

class SongTableViewController: UITableViewController {
	
	var songs = [Song]()
	var databaseRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")

    override func viewDidLoad() {
        super.viewDidLoad()
		loadSampleSongs()
    }
	


	func loadSampleSongs() {
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
			self.tableView.reloadData()
		}, withCancelBlock: { error in
		    print(error.description)
		})
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
		
		let url = NSURL(string: song.imgurl!)
		
		
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
			
			if error != nil {
				print("there's an error in the log")
			} else {
				
				dispatch_async(dispatch_get_main_queue()) {
					let image = UIImage(data: data!)
					cell.photoImageView.image = image
					
				}
			}
			
		}
		
		task.resume()
		
		cell.name.text = song.name
		
		
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
