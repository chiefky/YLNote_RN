//
//  YLAlgoStringListRow_5.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 在字符串 s 中找出第一个只出现一次的字符。如果没有，返回一个单空格。 s 只包含小写字母。

 示例 1:
 输入：s = "abaccdeff"
 输出：'b'
 
 示例 2:
 输入：s = ""
 输出：' '

 链接：https://leetcode.cn/problems/di-yi-ge-zhi-chu-xian-yi-ci-de-zi-fu-lcof
 */
class YLAlgoStringListRow_5: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let res = method_1("We are happy.")
        print("🍎1：\(res)")

    }
    
    func method_1(_ s:String) -> Character {
        guard !s.isEmpty else {
            return " "
        }
        var dict:[Character:Int] = [:]
        for char in s {
            if let _ = dict[char] {
                dict[char]! += 1;
            } else {
                dict[char] = 1;
            }

        }
        
        for c in s {
            if let count = dict[c], count == 1 {
                return c
            }
        }
        
        return " "
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_5"
    }
}
