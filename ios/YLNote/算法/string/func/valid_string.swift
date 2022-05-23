//
//  valid_string.swift
//  YLNote
//
//  Created by tangh on 2022/3/8.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation
/**
 题目概述：
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

 有效字符串需满足：

 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
 */

/// <#Description#>
/// - Parameter s: <#s description#>
/// - Returns: <#description#>
func isValid(_ s: String) -> Bool {
    if s.count%2 != 0  {
        return false
    }
    var stack:[String] = []
    let map = [")":"(","}":"{","]":"["]
    for char in s {
        if map.values.contains(char.description) {
            stack.append(char.description)
        } else if let value = map[char.description], value != stack.popLast() {
                return false
        }
    }
    return stack.isEmpty
    
}
