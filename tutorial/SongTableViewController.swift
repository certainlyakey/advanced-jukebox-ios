//
//  SongTableViewController.swift
//  tutorial
//
//  Created by AleksandrBeliaev on 17/03/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit
import Firebase

class SongTableViewController: UITableViewController{
	
//    @IBOutlet weak var SearchBar: UISearchBar!
	var songs = [Song]()
	var filteredSongs = [Song]()
	var databaseRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")

	let searchController = UISearchController(searchResultsController: nil)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
		self.refreshControl?.addTarget(self, action: #selector(SongTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)

		
		searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
		searchController.dimsBackgroundDuringPresentation = false
		definesPresentationContext = true
		tableView.tableHeaderView = searchController.searchBar
		
		// Setup the Scope Bar
		searchController.searchBar.scopeButtonTitles = ["All", "Song", "Artist", "Album"]
		tableView.tableHeaderView = searchController.searchBar
		
		
		loadSampleSongs()
		
		
	//	songs.sortInPlace ({$0.votes < $1.votes})

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
		if searchController.active && searchController.searchBar.text != "" {
			return filteredSongs.count
		}
		return songs.count
	}
	
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		// Table view cells are reused and should be dequeued using a cell identifier.
		songs.sortInPlace ({$0.votes > $1.votes})
		
		let cellIdentifier = "SongTableViewCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SongTableViewCell
		
		let song : Song
			
		if searchController.active && searchController.searchBar.text != "" {
			song = filteredSongs[indexPath.row]
		} else {
			song = songs[indexPath.row]
		}
		
		
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
		cell.artistName.text = song.album
		cell.albumName.text = song.artist
		cell.votes.text = String(song.votes!) + " votes"
		
		
		return cell
	}
	

	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		if segue.identifier == "ShowDetail" {
			let songDetailViewController = segue.destinationViewController as! SongViewController
			
			// Get the cell that generated this segue.
			if let selectedSongCell = sender as? SongTableViewCell {
				let indexPath = tableView.indexPathForCell(selectedSongCell)!
				//let selectedSong = songs[indexPath.row]
				let selectedSong: Song
				if searchController.active && searchController.searchBar.text != "" {
					selectedSong = filteredSongs[indexPath.row]
				} else {
					selectedSong = songs[indexPath.row]
				}
				songDetailViewController.song = selectedSong
			}
//		}
//		else if segue.identifier == "AddItem" {
//			print("Adding new meal.")
//		}
	}
	
	func filterContentForSearchText(searchText: String, scope: String = "All") {
		filteredSongs = songs.filter { song in
			switch scope {
				case "All" : return song.name!.lowercaseString.containsString(searchText.lowercaseString) || song.artist!.lowercaseString.containsString(searchText.lowercaseString) || song.album!.lowercaseString.containsString(searchText.lowercaseString)
				case "Song" : return song.name!.lowercaseString.containsString(searchText.lowercaseString)
				case "Artist" : return song.artist!.lowercaseString.containsString(searchText.lowercaseString)
				case "Album" : return song.album!.lowercaseString.containsString(searchText.lowercaseString)
				default : return false
			}
		}
		
		tableView.reloadData()
	}

	
	func refresh(refreshControl: UIRefreshControl) {
		loadSampleSongs()
		
		self.tableView.reloadData()
		refreshControl.endRefreshing()
	}



}


extension SongTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}


extension SongTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}