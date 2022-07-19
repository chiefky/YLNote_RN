//
//  YLNoteSwitchTableViewCell.swift
//  YLNote
//
//  Created by tangh on 2021/9/7.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit
typealias SwitchHandler = (Bool) -> ()
class YLNoteSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleButton: UIButton!
    
    @objc var switchHandler: SwitchHandler?
    @objc var articleHandler: ArticleHandler?

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = #colorLiteral(red: 0.9979326129, green: 0.6094605327, blue: 0.07266116887, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func articleButtonAction(_ sender: Any) {
        guard let handler = articleHandler else { return  }
        handler()
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        guard let s = sender as? UISwitch,
              let handler = switchHandler else { return  }
            handler(s.isOn)
    }
}
