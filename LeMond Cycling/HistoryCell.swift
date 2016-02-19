//
//  HistoryCell.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/21/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class HistoryCell: UITableViewCell {

    var cs = UIColors()

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cs.setStandard()
        self.backgroundColor = cs.background
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}