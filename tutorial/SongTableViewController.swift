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
		
		let song1 = Song(
			id: 1,
			name: "I have been loved by you",
			imgurl: "http://www.stihi.ru/pics/2009/06/08/896.jpg",
			votes:0,
			album: "My second album",
			artist: "M. Jackson",
			voted: false
			)!
		
		let song2 = Song(
			id: 2,
			name: "We are the champions",
			imgurl: "https://katrinajuniodesign.files.wordpress.com/2015/11/img_35701.jpg",
			votes:0,
			album: "Bohemian Rhapsody",
			artist: "Queen",
			voted:false
			)!
		
		let song3 = Song(
			id: 3,
			name: "Singing Pugs Make It Again",
			imgurl: "https://lh3.googleusercontent.com/-xVUsLxyTCC8/VhivX3sqAyI/AAAAAAAAJ3E/h53-Pc4Fz_s/s319-p/4.jpg",
			votes:0,
			album: "Album",
			artist: "David Bowie",
			voted:false
			)!
		
		let song4 = Song(
			id: 4,
			name: "Song of one person",
			imgurl: "https://pbs.twimg.com/profile_images/517367114475114496/1UH4GjQ1_400x400.jpeg",
			votes:3,
			album: "Here comes the sun",
			artist: "Leningrad",
			voted:false
			)!
		
		songs += [song1, song2, song3, song4]
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
				print("thers an error in the log")
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
