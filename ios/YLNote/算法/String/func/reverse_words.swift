//
//  reverse_words.swift
//  YLNote
//
//  Created by tangh on 2022/3/7.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

/**

 给你一个字符串 s ，逐个翻转字符串中的所有 单词 。
 单词 是由非空格字符组成的字符串。s 中使用至少一个空格将字符串中的 单词 分隔开。
 
 请你返回一个翻转 s 中单词顺序并用单个空格相连的字符串。
 
 说明：
 
 输入字符串 s 可以在前面、后面或者单词间包含多余的空格。
 翻转后单词间应当仅用一个空格分隔。
 翻转后的字符串中不应包含额外的空格。
 */

///
/// - Parameter s: <#s description#>
/// - Returns: <#description#>
func reverseWords(_ s: String) -> String {
    var strArr = s.split(separator: " ")
    var str = ""
    while strArr.count > 0 {
        if let word = strArr.last  {
            str += String(word)
            str += strArr.count > 1 ? " ":""
            strArr.removeLast()
        }
    }
    return str
}

/// 思路： 1. 截取最后一个单词 2. 原有字符串裁掉最后一个单词 3. last + " "+ 递归(2)
/// - Parameter s: 子串
/// - Returns: 最后一个完整单词
func res_reversWord(_ s: String) -> String {
    var tmp = s
    let preWord = subscriptLastWord(s: &tmp)
    var res = ""
    
    if preWord.isEmpty {
        return res
    } else {
        let remanent = res_reversWord(tmp)
        if remanent.isEmpty {
            res = preWord
        } else {
            res = preWord + " " + remanent
        }
    }
    print("-|\(res)")
    return res

}

func subscriptLastWord(s: inout String) -> String {
    if s.count <= 1 {
        return s
    }
    var right = s.count - 1
    while right >= 0, s[s.index(s.startIndex, offsetBy: right)] == " " {
        right -= 1
    }
    if right >= 0 {
        var offset = right        
        while offset >= 0, s[s.index(s.startIndex, offsetBy: offset)] != " " {
            offset -= 1
        }
        
        let offsetIndex = s.index(s.startIndex, offsetBy: offset+1)
        let rightIndex = s.index(s.startIndex, offsetBy: right)
        let word = s[offsetIndex...rightIndex]
        if offset < 0 {
            s.removeAll()
        } else {
            s.removeLast(s.count - offset)
        }
        return String(word)
    }
    return ""

}


/// 请尝试使用 O(1) 额外空间复杂度的原地解法。
/// - Returns: <#description#>

