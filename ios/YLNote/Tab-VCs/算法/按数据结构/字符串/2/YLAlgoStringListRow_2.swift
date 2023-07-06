//
//  YLAlgoStringListRow_2.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 请实现一个函数，把字符串 s 中的每个空格替换成"%20"。
 示例 1：
 输入：s = "We are happy."
 输出："We%20are%20happy."
 链接： https://leetcode.cn/problems/ti-huan-kong-ge-lcof/
 */
class YLAlgoStringListRow_2: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let res = method_1("We are happy.")
        print("🍎1：\(res)")

    }
    
    func method_1(_ s:String) -> String {
        var res = ""
        for char in s {
            if char == " " {
                res += "%20"
            } else {
                res += "\(char)"
            }
        }
        return res
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_2"
    }
}
