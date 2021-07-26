//
//  OrderNameTableViewCell.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/9/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class OrderNameTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLAbel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
