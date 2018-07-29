//  CMPT 276 Project Group 12 - Smart Apps
//  GoalTableViewCell.swift
//
//
//  Created by Stanislaw Kalinowski on 2018-07-02.
//  Copyright © 2018 Stanislaw Kalinowski. All rights reserved.
//
// Table From the Goal Page

import UIKit

class GoalTableViewCell: UITableViewCell {

    //Mark: properties
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
