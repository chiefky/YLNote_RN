//
//  YLAlgoStringListRow_3.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**题目描述：
 给定两个字符串 text1 和 text2，返回这两个字符串的最长 公共子序列 的长度。如果不存在 公共子序列 ，返回 0 。
 一个字符串的 子序列 是指这样一个新的字符串：它是由原字符串在不改变字符的相对顺序的情况下删除某些字符（也可以不删除任何字符）后组成的新字符串。
 
 例如，"ace" 是 "abcde" 的子序列，但 "aec" 不是 "abcde" 的子序列。
 两个字符串的 公共子序列 是这两个字符串所共同拥有的子序列。
 示例 1：
 > 输入：text1 = "abcde", text2 = "ace"
 > 输出：3
 > 解释：最长公共子序列是 "ace" ，它的长度为 3 。
 
 链接：https://leetcode-cn.com/problems/longest-common-subsequence
 */

class YLAlgoStringListRow_3: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @objc func testMethod1() {
        let str1 = "aa"
        let str2 = "aa"
        let res:Int = method_1(str1, str2)
        print("🍎：\(res)")
        
    }
    
    func method_1(_ s1: String,_ s2:String) -> Int {
        guard s1.count > 0, s2.count > 0 else {
            return 0;
        }

        
        return s1.count
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_3"
    }
}
