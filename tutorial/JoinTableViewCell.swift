//
//  JoinTableViewCell.swift
//  adv-jukebox
//
//  Created by Ondrej on 28/04/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit

class JoinTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var typePlaylistLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
