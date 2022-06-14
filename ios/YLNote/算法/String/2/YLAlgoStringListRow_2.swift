//
//  YLAlgoStringListRow_2.swift
//  YLNote
//
//  Created by tangh on 2022/3/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 3. 无重复字符的最长子串
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。

示例 1:
> 输入: s = "abcabcbb"
> 输出: 3
> 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。

 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 */

class YLAlgoStringListRow_2: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod1() {
        let str = "abcabcbb"
        let resLen:Int = method_1(str)// lengthOfLongestSubstring(str)
        print("🍎: \(resLen)")
    }
    
    func method_1(_ s: String) -> Int {
        guard s.count > 1 else {
            return s.count
        }
        var window:[Character] = []
        var maxLength = 0        
        for char in s {
            while window.contains(char) {
                window.removeFirst()
            }
            window.append(char)
            maxLength = max(window.count, maxLength)
        }
        
        return maxLength;
    }
    
    @objc func testMethod2() {
        let str = "abcabcbb"
        let resLen:Int = method_1(str)// lengthOfLongestSubstring(str)
        print("🍎: \(resLen)")
    }
    func method_2(_ s: String) -> Int {
        guard s.count > 1 else {
            return s.count
        }
        return s.count
    }

    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_2"
    }
}
