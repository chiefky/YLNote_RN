//
//  YLQuestionTableViewCell.swift
//  YLNote
//
//  Created by tangh on 2021/3/29.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit
typealias ArticleHandler = () -> ()
class YLQuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextPage: UIImageView!
    @objc var subtitle: String = "" {
        didSet {
            self.subtitleLabel.isHidden = subtitle.isEmpty;
            self.subtitleLabel.text = subtitle;
        }
    }
    @objc var articleHandler: ArticleHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = #colorLiteral(red: 0.9979326129, green: 0.6094605327, blue: 0.07266116887, alpha: 1)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subtitleLabel.isHidden = subtitle.isEmpty;
        
    }

    override func layoutSubviews() {
        super.layoutSubviews();
        remakeLabelConstraint()
    }

    @IBAction func articleActionClicked(_ sender: Any) {
        if let handler = articleHandler {
            handler()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func remakeLabelConstraint() {
        if subtitle.isEmpty {
            titleLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview();
                make.leading.equalTo(articleButton.snp.trailing).offset(5);
                make.trailing.equalTo(nextPage.snp.leading).offset(-5);
                make.height.equalTo(30);
            };
            
        } else {
            titleLabel.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(7);
                make.leading.equalTo(articleButton.snp.trailing).offset(5);
                make.trailing.equalTo(nextPage.snp.leading).offset(-5);
                make.height.equalTo(18);
            };
            
            subtitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(3);
                make.leading.equalTo(titleLabel);
                make.trailing.equalTo(titleLabel);
                make.height.equalTo(12);
            }
        }
    }
}
