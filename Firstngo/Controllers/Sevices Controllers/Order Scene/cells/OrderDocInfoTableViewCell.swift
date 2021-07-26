//
//  OrderDocInfoTableViewCell.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/16/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class OrderDocInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
