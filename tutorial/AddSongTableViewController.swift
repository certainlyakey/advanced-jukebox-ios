//
//  AddSongTableViewController.swift
//  adv-jukebox
//
//  Created by Ondrej on 03/05/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit
import Firebase

class AddSongTableViewController: UITableViewController{

	var songs = [Song]()
	var filteredSongs = [Song]()
	var databaseRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")
	
	let searchController = UISearchController(searchResultsController: nil)
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.dimsBackgroundDuringPresentation = false
		definesPresentationContext = true
		tableView.tableHeaderView = searchController.searchBar
		
		// Setup the Scope Bar
		searchController.searchBar.scopeButtonTitles = ["All", "Song", "Artist", "Album"]
		tableView.tableHeaderView = searchController.searchBar
		
		loadSampleSongs()
		
    }

	
	func loadSampleSongs() {
		let songsRef = databaseRef.childByAppendingPath("databaseSongs")
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
		
		let cellIdentifier = "AddSongTableViewCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddSongTableViewCell
		
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
					cell.imageImage.image = image
					
				}
			}
			
		}
		
		task.resume()
		
		cell.songNameLabel.text = song.name
		cell.artistNameLabel.text = song.album
		cell.albumNameLabel.text = song.artist
		
		
		return cell
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AddSongTableViewController: UISearchBarDelegate {
	// MARK: - UISearchBar Delegate
	func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
	}
}


extension AddSongTableViewController: UISearchResultsUpdating {
	// MARK: - UISearchResultsUpdating Delegate
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		filterContentForSearchText(searchController.searchBar.text!, scope: scope)
	}
}
