//
//  PlaylistTableViewController.swift
//  adv-jukebox
//
//  Created by Ondrej on 27/04/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit
import Firebase

class PlaylistTableViewController: UITableViewController{
	
	var playlists =  [Playlist]()
	var databaseRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
	loadSamplePlaylist()
		
	
	}
	
	func loadSamplePlaylist(){
        self.playlists = []
        let playlist1 = Playlist (id : 1, name : "Playlist0", type : "pub")!
		let playlist2 = Playlist (id : 2, name : "Playlist1", type : "pub")!
		
		
		self.playlists += [playlist1, playlist2]

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
       
        return playlists.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PlaylistTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PlaylistTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let playlist = playlists[indexPath.row]
        
        cell.playlistName.text = playlist.name
        cell.playlistType.text = playlist.type

        
        return cell
    }

}