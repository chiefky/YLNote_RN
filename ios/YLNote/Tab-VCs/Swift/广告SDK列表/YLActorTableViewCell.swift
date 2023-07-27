//
//  YLActorTableViewCell.swift
//  YLNote
//
//  Created by tangh on 2023/7/24.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLActorTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    @IBOutlet weak var txtLabel: UILabel!
    
    @IBOutlet weak var picView: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
