//
//  YLAlgoStringListRow_13.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 67. 把字符串转换成整数
 
 写一个函数 StrToInt，实现把字符串转换成整数这个功能。不能使用 atoi 或者其他类似的库函数。
 
 首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。
 当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。
 该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。
 注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。
 在任何情况下，若函数不能进行有效的转换时，请返回 0。
 说明：
 假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−2^31,  2^31 − 1]。如果数值超过这个范围，请返回  INT_MAX (2^31 − 1) 或 INT_MIN (−2^31) 。
 https://leetcode.cn/problems/ba-zi-fu-chuan-zhuan-huan-cheng-zheng-shu-lcof/description/
 */
class YLAlgoStringListRow_13: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let s1 = "20000000000000000000"
        let res = strToInt(s1)
        print("🍎1：\(res)")
        
    }
    
    /// 分段处理（在非空字符处（判断符号）分段）
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    func strToInt(_ str: String) -> Int {
        var words = str.trimmingCharacters(in: CharacterSet.whitespaces);
        guard !words.isEmpty else {
            return 0
        }
        
        var res = 0;
        var sign = 1;
        if words.first == "-" {
            sign = -1;
            words.removeFirst()
        } else if words.first == "+" {
            sign = 1;
            words.removeFirst();
        }
                
        for char in words {
            if !char.isNumber {break};
            res = res*10 + Int(String(char))!
            if sign == 1 && res > Int32.max {
                return Int(Int32.max);
            } else if sign == -1 && (-res < -Int32.max) {
                return Int(Int32.min)
            }
        }
        res *= sign;
        return res;
    }
    
    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_13"
    }
}
