//
//  AdminTableViewCell.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/10/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class AdminTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var chatTextLabel: EdgeInsetLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
