//
//  YLAlgoRootViewController.swift
//  YLNote
//
//  Created by tangh on 2023/7/6.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLAlgoRootViewController: UIViewController {
    
    /// 默认显示left
    var firstHidden = false {
        didSet {
            leftVC.view.isHidden = firstHidden;
            rightVC.view.isHidden = !firstHidden;
        }
    }
    var segment: UISegmentedControl = UISegmentedControl()
    var contentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705254436, alpha: 1)
        setupUI()
    }
    
    func setupUI() {
        segment = UISegmentedControl(items: ["按算法方法","按数据结构"])
        segment.selectedSegmentIndex = 0 // 设置默认选中first
        segment.frame = CGRect(x: 0, y: 0, width: 200, height: 35)
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        // 设置未选中状态的背景颜色
        segment.setBackgroundImage(UIImage.imageWithColor(color: UIColor(hex: "#F2F2F7")), for: .normal, barMetrics: .default)
        // 设置选中状态的背景颜色
        let selectColor = UIColor(hex: "#EF8B34")

//        #colorLiteral(red: 0.9996853471, green: 0.5196825266, blue: 0.00617618626, alpha: 1)
        segment.setBackgroundImage(UIImage.imageWithColor(color: selectColor), for: .selected, barMetrics: .default)
        segment.setBackgroundImage(UIImage.imageWithColor(color: .white), for: .normal, barMetrics: .default)

        // 设置选中状态的文本颜色
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 17)], for: .selected)
                
        // 设置未选中状态的文本颜色
        segment.setTitleTextAttributes([ .foregroundColor: selectColor, .font: UIFont.systemFont(ofSize: 15)], for: .normal)
        navigationItem.titleView = segment
        
        if segment.selectedSegmentIndex == 0 {
            addSubViewController(leftVC)
        } else {
            addSubViewController(rightVC)
        }
    }
    
    /// 添加子视图
    /// - Parameter vc: 子视图vc
    func addSubViewController(_ vc:UIViewController) {
        guard vc.parent == nil else { return }
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        vc.view.isHidden = false;
        vc.didMove(toParent: self)
    }
    
    
    
    @objc func segmentedControlValueChanged(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("000000")
            addSubViewController(leftVC)
            firstHidden = false
        case 1:
            addSubViewController(rightVC)
            firstHidden = true;
            print("111111")
        default:
            print("others")
        }
    }
    
    //MARK: lazy
    lazy var leftVC: YLAlgoSubControllerLeft = {
        let left = YLAlgoSubControllerLeft()
        return left
    }()
    lazy var rightVC: YLAlgoSubControllerRight = {
        let r = YLAlgoSubControllerRight()
        return r
    }()
    
}
