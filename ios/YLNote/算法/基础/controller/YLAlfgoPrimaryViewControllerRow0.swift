//
//  YLAlfgoPrimaryViewControllerRow0.swift
//  YLNote
//
//  Created by tangh on 2022/3/1.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit


class YLAlfgoPrimaryViewControllerRow0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: func
    
    /// 递归
    @objc func testSort_recursive() {
        let array = [-1,0,3,5,9,12]
        let res = recursive_binary_search(array, target: 2)
        print("🦀： \(res)")
    }
    
    /// 迭代
    @objc func testSort_iteration() {
        let array = [-1,0,3,5,9,12]
        let res = iterator_binary_search(array, target: 2)
        print("🦀： \(res)")
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Alfgo_primary_row_0"
    }


}
