//
//  YLAlgoPrimaryViewControllerRow2.swift
//  YLNote
//
//  Created by tangh on 2022/3/2.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoPrimaryViewControllerRow2: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testSort_recursive()  {
        let num = [1,2,9,4,2,3,5,8]
        let arr = mergesort(num)
        print("\(arr)")
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_primary_row_2"
    }

}
