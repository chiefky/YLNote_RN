//
//  YLAlgoStringViewControllerRow3.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoStringViewControllerRow3: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @objc func testSubsequence_dynamic_len() {
        let str1 = "aa"
        let str2 = "aa"
        let res:Int = longestCommonSubsequence(str1, str2)
        print("🍎：\(res)")
        
    }


    @objc func testSubsequence_dynamic_str() {
        let str1 = "aa"
        let str2 = "aa"
        let res:Int = longestCommonSubsequence(str1, str2)
        print("🍎：\(res)")
        
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_3"
    }
}
