//
//  Song.swift
//  tutorial
//
//  Created by AleksandrBeliaev on 17/03/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit

class Song {
	// MARK: Properties
	
	var id: Int
	var name: String
	var photo: UIImage?
	var votes: Int
	var album: String?
	var artist: String?
	var voted: Bool?
	
	// MARK: Initialization
 
	init?(
		id: Int,
		name: String,
		photo: UIImage?,
		votes: Int,
		album: String?,
		artist: String?,
		voted: Bool?
		) {
		self.id = id
		self.name = name
		self.photo = photo
		self.votes = votes
		self.album = album
		self.artist = artist
		self.voted = voted
		
		if name.isEmpty || id < 1 {
			return nil
		}
	}
	
}