//
//  YLAlgoPrimaryViewControllerRow1.swift
//  YLNote
//
//  Created by tangh on 2022/3/2.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
var nums = [3,5,9,-1,2,0,12]

class YLAlgoPrimaryViewControllerRow1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testSort_recursive()  {
        let arr = quicksort(&nums,low: 0,high: nums.count-1)
        print("\(arr)")
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_primary_row_1"
    }

}
