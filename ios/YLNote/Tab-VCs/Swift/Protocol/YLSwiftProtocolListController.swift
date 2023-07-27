//
//  YLSwiftProtocolListController.swift
//  YLNote
//
//  Created by tangh on 2023/7/23.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLSwiftProtocolListController: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testProtocolInherit()  {
        let model = YLDelModel()
        model.testFather(name: "张三")
        
    }
    
    @objc func testProtocolExtension() {
        let model = YLDelClassModel()
        model.sayHello()
    }
    
    /// override
    /// - Returns: <#description#>
    override func fileName() -> String {
        return "protocol_list"
    }
}

