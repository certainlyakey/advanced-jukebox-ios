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
	
	var name: String
	var photo: UIImage?
	var rating: Int
	var album: String?
	var artist: String?
	
	// MARK: Initialization
 
	init?(name: String, photo: UIImage?, rating: Int, album: String?, artist: String?) {
		self.name = name
		self.photo = photo
		self.rating = rating
		self.album = album
		self.artist = artist
		
		if name.isEmpty || rating < 0 {
			return nil
		}
	}
	
}