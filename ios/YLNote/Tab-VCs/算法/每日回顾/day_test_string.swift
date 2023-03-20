//
//  day_test_string.swift
//  YLNote
//
//  Created by tangh on 2022/6/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation
import UIKit

func testString() {
    let s2 = "abcabcbb";
    let res = fix_lengthOfLongestSubstring(s2)
    print("🔤结果：\(res)")
}

/// 无重复最长子串
/// - Parameter s: 字符串
/// - Returns: 最长子串的长度
func fix_lengthOfLongestSubstring(_ s: String) -> Int {
    guard s.count > 1 else {
        return s.count
    }
    var res = 0
    var window:[Character] = []
    for char in s {
        while window.contains(char) {
            window.removeFirst()
        }
        window.append(char)
        res = max(res, window.count)
    }
    return res
}

func lookforSuper(_ view1: UIView,_ view2:UIView) -> UIView {

    var a:UIView? = view1.superview, b = view2.superview
    if a == nil {
        a = view2
    }
    while let tmpA = a, let tmpB = b {
        if tmpA == tmpB {
            return tmpA
        }
        a = tmpA.superview
        b = tmpB.superview
    }
    
    return a!
}


/// 翻转单词顺序：
/// - Parameter s: "  hello world!  "
/// - Returns: "world! hello"
func string_method_qes_0(_ s: String) -> String {
    let words = s.split(separator: " ")
    return words.reversed().joined(separator: " ")
}

/// - [ ] 判断字符串是否闭合
/// - Parameter s: "([)]","()[]{}"
/// - Returns: false,true
func string_method_qes_1(_ s:String) -> Bool {
    guard s.count > 1 else { // 出错点1： 没有考虑一个括号的情况
        return false
    }
    let dict:[Character:Character] = [")":"(",
                "]":"[",
                "}":"{"]
    var leftBrackets:[Character] = []
    for char in s {
        if !dict.keys.contains(char) {
            // 左括号
            leftBrackets.append(char)
            print("'\(char)'进栈,\(leftBrackets)");
        } else {
            // 右括号
            if let spouse_char = dict[char], spouse_char == leftBrackets.last {
                leftBrackets.removeLast()
                print("'\(spouse_char)'出栈,\(leftBrackets)");
            } else {
                return false
            }
        }
    }
    return leftBrackets.isEmpty // 出错点2： 没有考虑只有单侧括号的情况，如： “((”
}

/// - [ ] 替换空格
/// - Parameter s: "We are happy.", "   "
/// - Returns: "We%20are%20happy.", "%20%20%20"
func string_method_qes_2(_ s:String) -> String {
    var res = ""
    for char in s {
        res += char == " " ? "%20" : "\(char)"
    }
    return res
}

func string_method_qes_3(_ s:String) -> Character {
    var dic:[Character:Int] = [:]
    for char in s {
        if dic.keys.contains(char),let count:Int = dic[char] {
            dic[char] = count + 1
        } else {
            dic[char] = 1
        }
    }
    
    for char in s {
        if dic[char] == 1 {
            return char
        }
    }
    
    return " "
}

/// 无重复字符的最长子串
/// - Parameter s: "abcabcbb"
/// - Returns: 3
func string_method_qes_4(_ s:String) -> Int {
    var window:[Character] = []
    var length = 0
    for char in s {
        while window.contains(char) { // 注意：移除前面字符时用while循环 比 使用数组截取 耗时时间短
            window.removeFirst()
        }
        window.append(char)
        length = max(length, window.count)
        print("🪟:\(window)")
    }
    
    return length
}

/// 反转字符串
/// - Parameter s: “abcd”
func string_method_qes_6(_ s: inout [Character]) {
    var left = 0,right = s.count-1
    while left < right {
        s.swapAt(left, right)
        left += 1;
        right -= 1;
    }
}

/// 反转字符串中的单词 III
/// - Parameter s: "Let's take LeetCode contest"
/// - Returns: "s'teL ekat edoCteeL tsetnoc"
func string_method_qes_7(_ s: String) -> String {
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

