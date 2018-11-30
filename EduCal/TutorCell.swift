//
//  TutorCell.swift
//  EduCal
//
//  Created by Andy on 11/29/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit

class TutorCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
