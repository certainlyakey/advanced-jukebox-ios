//
//  AddSongTableViewCell.swift
//  adv-jukebox
//
//  Created by Ondrej on 03/05/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit

class AddSongTableViewCell: UITableViewCell {
    // MARK: Properties
  
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var InPlaylistLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var imageImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
