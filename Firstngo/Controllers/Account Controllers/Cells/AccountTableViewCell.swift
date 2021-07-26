//
//  AccountTableViewCell.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/24/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var chekImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
