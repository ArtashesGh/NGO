//
//  UserServicesTableViewCell.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/6/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class UserServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceTypeLabel: EdgeInsetLabel!
    @IBOutlet weak var servicesNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
