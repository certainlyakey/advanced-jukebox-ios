//
//  PlaylistTableViewCell.swift
//  adv-jukebox
//
//  Created by Ondrej on 27/04/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
	// MARK: Properties
    @IBOutlet weak var playlistName: UILabel!
	@IBOutlet weak var playlistType: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}