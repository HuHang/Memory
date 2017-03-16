//
//  MainMsgTableViewCell.swift
//  Memory
//
//  Created by Charlot on 17/1/14.
//  Copyright © 2017年 Charlot. All rights reserved.
//

import UIKit

class MainMsgTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
