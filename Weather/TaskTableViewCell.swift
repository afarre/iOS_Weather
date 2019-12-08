//
//  TaskTableViewCell.swift
//  Weather
//
//  Created by Alumne on 19/11/19.
//  Copyright © 2019 salle. All rights reserved.
//
import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
