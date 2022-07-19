//
//  sub_string.swift
//  YLNote
//
//  Created by tangh on 2022/3/9.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation
/**
 3. 无重复字符的最长子串
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。

示例 1:
> 输入: s = "abcabcbb"
> 输出: 3
> 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


/// 返回最长子串的length
/// - Parameter s: string
/// - Returns: length
func lengthOfLongestSubstring(_ s: String) -> Int {
    guard s.count >= 2 else {
        return s.count
    }
    
    var window = [Character]()
    var res = 0
    var win_l = 0 ;
    for (index,char) in s.enumerated() {
        while window.contains(char) {
            window.removeFirst()
            win_l += 1
        }
        window.append(char)
        res = max(res,(index - win_l + 1))
    }
    return res
}

/// 返回最长的子串（头尾下标、字符串、长度）均可
/// - Parameter s: string
/// - Returns: （头尾下标、字符串、长度）均可
func lengthOfLongestSubstring(_ s: String) -> String {
    guard s.count >= 2 else {
        return s
    }
    
    var window = [Character]()
    /// 子串的头尾下标
    var res_l = 0, res_r = 0;
    /// 窗口的左右游标
    var win_l = 0 ,win_r = 0;
    for (index,char) in s.enumerated() {
        while window.contains(char) {
            window.removeFirst()
            win_l += 1
        }
        window.append(char)
        win_r = index
        if (res_r - res_l) < (win_r - win_l) {
            res_l = win_l
            res_r = win_r
        }
    }

    let indexL = s.index(s.startIndex, offsetBy: res_l)
    let indexR = s.index(s.startIndex, offsetBy: res_r)
    let sub = s[indexL...indexR]
    return String(sub)
    
}
