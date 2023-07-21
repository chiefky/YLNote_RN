//
//  YLUITestListController.swift
//  YLNote
//
//  Created by tangh on 2023/7/21.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLUITestListController: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        // Do any additional setup after loading the view.
    }

    @objc func testLifeCycleView() {
        let vc = YLViewLifeCycleController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func testLifeCycleVC() {
        let vc = YLVCLifeCycleController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: -override
    override func fileName() -> String {
        return "ui_test"
    }
    
}
