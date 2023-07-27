//
//  YLViewLifeCycleController.swift
//  YLNote
//
//  Created by tangh on 2021/1/25.
//  Copyright © 2021 tangh. All rights reserved.
//

import UIKit

class YLViewLifeCycleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("销毁：")
    }
    //MARK: function
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addCustomView()
    }
    
    func addXibView() {
        let views = Bundle.main.loadNibNamed("YLLifeCycleView", owner:self, options:nil)
        if let view = views?.first as? YLLifeCycleView {
            view.backgroundColor = .systemPink
            view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
            self.view.addSubview(view)
            
            let subView = UIView()
            subView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            subView.backgroundColor = .yellow
            view.addSubview(subView)
        }
    }
    
    func addCustomView() {
        print("初始化：")
        let lcView = YLLifeCycleView.init()
        print("载入：")
        lcView.backgroundColor = .systemPink
        lcView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(lcView)
        let subView = UIView()
        subView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        subView.backgroundColor = .yellow
        lcView.addSubview(subView)
    }
    
   
}
