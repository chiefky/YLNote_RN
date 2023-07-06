//
//  YLAlgoStringListRow_7.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 . 反转字符串中的单词 III
 给定一个字符串 s ，你需要反转字符串中每个单词的字符顺序，同时仍保留空格和单词的初始顺序。

 示例 1：
 输入：s = "Let's take LeetCode contest"
 输出："s'teL ekat edoCteeL tsetnoc"
 
 https://leetcode.cn/problems/reverse-words-in-a-string-iii/
 */
class YLAlgoStringListRow_7: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let str = "Let's take LeetCode contest"
        let res = method_1(str)
        print("🍎1：\(res)")

    }
    
    func method_1(_ s:String) -> String {
        guard s.count > 1 else {
            return s
        }
        let arr = s.split(separator: " ")
        var res:[String] = []
        for word in arr {
            var chars = Array(word)
            var left = 0,right = chars.count-1
            while left < right {
                chars.swapAt(left, right)
                left += 1;
                right -= 1;
            }
            res.append(String(chars))
        }
        return res.joined(separator: " ")
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_7"
    }
}
