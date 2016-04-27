//
//  Playlist.swift
//  adv-jukebox
//
//  Created by Ondrej on 27/04/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit
import Firebase

class Playlist {
	// MARK: Properties
	
	var id: Int?
	var name: String?
	var type: String?
	var songs = [Song]()
	
	var databaseRef = Firebase(url:"https://radiant-torch-3216.firebaseio.com")
	
	// MARK: Initialization
 
	init?( id: Int?, name: String?, type: String?, songs : [Song]) {
		self.id = id
		self.name = name
		self.type = type
		self.songs = songs

		
		if name!.isEmpty || id < 1 {
			return nil
		}
	}
	
	init?( id: Int?, name: String?, type: String?) {
		self.id = id
		self.name = name
		self.type = type
		
		
		if name!.isEmpty || id < 1 {
			return nil
		}
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
		},withCancelBlock: { error in
			print(error.description)
		})
	}
}
