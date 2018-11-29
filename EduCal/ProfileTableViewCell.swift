//
//  ProfileTableViewCell.swift
//  EduCal
//
//  Created by Lily Bhattacharjee on 11/28/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var propertyName: UILabel!
    @IBOutlet var propertyValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
