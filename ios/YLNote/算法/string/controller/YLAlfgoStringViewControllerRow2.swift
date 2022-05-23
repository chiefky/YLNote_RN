//
//  YLAlfgoStringViewControllerRow0.swift
//  YLNote
//
//  Created by tangh on 2022/3/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlfgoStringViewControllerRow2: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testSubstring_window_len() {
        let str = "aa"
        let resLen:Int = lengthOfLongestSubstring(str)
        print("🍎: \(resLen)")
    }
    
    @objc func testSubstring_window_str() {
        let str = "aa"
        let res:String = lengthOfLongestSubstring(str)
        print("🍎：\(res)")
    }

    //MARK: override
    override func fileName() -> String {
        return "Alfgo_string_row_2"
    }
}
