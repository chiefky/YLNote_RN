//
//  YLGroupNormalHeaderView.swift
//  YLNote
//
//  Created by tangh on 2021/10/22.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit

class YLGroupNormalHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = #colorLiteral(red: 0.9567206502, green: 0.496935308, blue: 0.0157162305, alpha: 1)
        self.backgroundView = backView
    }

    @objc var title: String = "" {
        didSet {
            titleLabel.text = title
            
        }
    }
}
