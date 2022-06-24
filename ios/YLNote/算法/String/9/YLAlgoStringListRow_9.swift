//
//  YLAlgoStringListRow_9.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
给定一个字符串 s ，通过将字符串 s 中的每个字母转变大小写，我们可以获得一个新的字符串。
 返回 所有可能得到的字符串集合 。以 任意顺序 返回输出。

 示例 1：
 输入：s = "a1b2"
 输出：["a1b2", "a1B2", "A1b2", "A1B2"]
 
 示例 2:
 输入: s = "3z4"
 输出: ["3z4","3Z4"]

 https://leetcode.cn/problems/letter-case-permutation/
 */
class YLAlgoStringListRow_9: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let s1 = "a2b"
        let res = method_1(s1)
        print("🍎1：\(res)")
        
    }
    /// 字符串的排列
    /// - Parameters:
    ///   - s1: "ab"
    ///   - s2: "eidbaooo"
    /// - Returns: true
    func method_1(_ s: String) -> [String] {
        guard s.count > 0 else {
            return []
        }
        return []
    }
    
    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_9"
    }
}
