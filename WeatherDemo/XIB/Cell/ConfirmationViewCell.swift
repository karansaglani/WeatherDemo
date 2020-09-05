//
//  ConfirmationViewCell.swift
//  JnKGB
//
//  Created by admin on 21/06/19.
//  Copyright © 2019 Hemant Hindlekar. All rights reserved.
//

import UIKit

class ConfirmationViewCell: UITableViewCell {

    
    @IBOutlet weak var labelLine: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
