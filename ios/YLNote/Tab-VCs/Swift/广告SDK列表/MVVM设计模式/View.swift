//
//  YLADCustomView.swift
//  YLNote
//
//  Created by tangh on 2023/7/25.
//  Copyright © 2023 tangh. All rights reserved.
//

import Foundation

protocol YLAdCellDelegate: AnyObject {
    static var cellIdentifier: String { get }
    static func dequeueReusableCell(from tableView: UITableView, for indexPath: IndexPath) -> Self
    func setupUI()
}

protocol YLAdViewDataSource {
    func configure(with data: YLAdCellModelProtocol)
}

extension YLAdCellDelegate where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static func dequeueReusableCell(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? Self else {
            fatalError("Unable to dequeue cell with identifier: \(Self.cellIdentifier)")
        }

        cell.setupUI()
        return cell
    }
}

typealias YLAdCellProtocol = YLAdCellDelegate & YLAdViewDataSource
/// 图文
class YLAdSmallCell: UITableViewCell,YLAdCellProtocol {
    var flag = false
    var exposure: Bool {
        get {
            return flag
        }
        set {
            flag = newValue
        }
    }
    let imgView = UIImageView()
    let label = UILabel()
    
    func configure(with data: YLAdCellModelProtocol) {
        guard let data = data as? YLAdSmallCellModel else {
            return
        }
        imgView.sd_setImage(with: URL(string: data.imageUrl))
        label.text = data.title
    }
    
    func setupUI()  {
        imgView.backgroundColor = .lightGray
        self.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(80)
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
        }
        
        self.addSubview(label)
//        label.backgroundColor = .systemGray
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        label.numberOfLines = 0
        label.snp.makeConstraints { make in
            make.left.equalTo(imgView.snp.right).offset(8)
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }
    }
}

/// 大图
class YLAdBigCell: UITableViewCell,YLAdCellProtocol {
    var flag = false
    var exposure: Bool {
        get {
            return flag
        }
        set {
            flag = newValue
        }
    }

    let imgView = UIImageView()
    func configure(with data: YLAdCellModelProtocol) {
        guard let cellData = data as? YLAdBigCellModel else {
            return
        }
        
        imgView.sd_setImage(with: URL(string: cellData.imageUrl))
    }
    
    func setupUI()  {
        imgView.backgroundColor = .lightGray
        self.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }
}

/// 三图
class YLAdThreeCell: UITableViewCell,YLAdCellProtocol {
    var flag = false
    var exposure: Bool {
        get {
            return flag
        }
        set {
            flag = newValue
        }
    }

    func configure(with data: YLAdCellModelProtocol) {
        guard let cellData = data as? YLAdThreeCellModel else {
            return
        }
        
        for (idx,imgView) in imgViews.enumerated() {
            if let url = cellData.adImages[safe: idx] {
                imgView.sd_setImage(with: URL(string: url))
            }
        }
    }
    let firstView = UIImageView()
    let secondView = UIImageView()
    let thirdView = UIImageView()
    var imgViews:[UIImageView] = []
    let containerView = UIStackView()
    
    func setupUI()  {
        imgViews = [firstView,secondView,thirdView]
        containerView.axis = .horizontal
        containerView.spacing = 10
        containerView.alignment = .fill
        containerView.distribution = .fillEqually
        self.addSubview(containerView)
        
        // 使用SnapKit设置约束
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        for imageView in imgViews {
            containerView.addArrangedSubview(imageView)
            imageView.backgroundColor = .lightGray
        }
    }

}


/// gif
class YLAdGifCell: UITableViewCell,YLAdCellProtocol {
    var flag = false
    var exposure: Bool {
        get {
            return flag
        }
        set {
            flag = newValue
        }
    }

    let imgView = UIImageView()
    func configure(with data: YLAdCellModelProtocol) {
        guard let cellData = data as? YLAdBigCellModel else {
            return
        }
        imgView.sd_setImage(with: URL(string: cellData.imageUrl))
    }
    
    func setupUI()  {
        imgView.backgroundColor = .lightGray
        self.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }
}

/// video big
class YLAdVideoBigCell: UITableViewCell,YLAdCellProtocol {
    var flag = false
    var exposure: Bool {
        get {
            return flag
        }
        set {
            flag = newValue
        }
    }

    let imgView = UIImageView()
    func configure(with data: YLAdCellModelProtocol) {
        guard let cellData = data as? YLAdBigCellModel else {
            return
        }
        
        imgView.sd_setImage(with: URL(string: cellData.imageUrl))
    }
    
    func setupUI()  {
        imgView.backgroundColor = .lightGray
        self.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }
}

/// video small
class YLAdVideoSmallCell: UITableViewCell,YLAdCellProtocol {
    var flag = false
    var exposure: Bool {
        get {
            return flag
        }
        set {
            flag = newValue
        }
    }

    let imgView = UIImageView()
    let label = UILabel()
    
    func configure(with data: YLAdCellModelProtocol) {
        guard let data = data as? YLAdSmallCellModel else {
            return
        }
        imgView.sd_setImage(with: URL(string: data.imageUrl))
        label.text = data.title
    }
    
    func setupUI()  {
        imgView.backgroundColor = .blue
        self.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(80)
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
        }
        label.text = "标题"
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(imgView.snp_rightMargin).offset(10)
            make.top.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
    }
    
}

/// 全屏
class YLAdFullScreenView: UIView {
    var flag = false
    var exposure: Bool {
        get {
            return flag
        }
        set {
            flag = newValue
        }
    }

    let imgView = UIImageView()
    func configure(with data: YLAdCellModelProtocol) {
        guard let data = data as? YLAdFullScreenViewModel else {
            return
        }
        
        imgView.sd_setImage(with: URL(string: data.imageUrl))
    }
    
    func setupUI()  {
        imgView.backgroundColor = .lightGray
        self.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }
}

