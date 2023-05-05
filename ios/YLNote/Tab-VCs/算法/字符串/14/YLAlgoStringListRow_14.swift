//
//  YLAlgoStringListRow_14.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 20. 表示数值的字符串
 请实现一个函数用来判断字符串是否表示数值（包括整数和小数）。
 https://leetcode.cn/problems/biao-shi-shu-zhi-de-zi-fu-chuan-lcof/description/
 
 */
class YLAlgoStringListRow_14: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    enum CharType: Int {
        case space = 0;
        case sign;
        case digit;
        case dot;
        case exp;
        case illegal;
    }
    @objc func testMethod() {
        let s1 = ".1"
        let res = isNumber(s1)
        print("🍎1：\(res)")
        
    }
    
    /// 状态机（状态机转移表见：）
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    func isNumber(_ s: String) -> Bool {
        // 状态转移矩阵（-1:代表无法继续转移）
        let transfer:[[Int]] = [
            [0,1,2,4,-1],
            [-1,-1,2,4,-1],
            [8,-1,2,3,5],
            [8,-1,3,-1,5],
            [-1,-1,3,-1,-1],
            [-1,6,7,-1,-1],
            [-1,-1,7,-1,-1],
            [8,-1,7,-1,-1],
            [8,-1,-1,-1,-1],
        ]

        var state = 0;
        for c in s {
            let type = charType(c)
            if type == .illegal  { return false }
            state = transfer[state][type.rawValue];
            if state == -1 {
                return false;
            }

        }
        return state == 2 || state == 3 || state == 7 || state == 8 ;
        
    }
    
    /// 根据字符返回对应类型
    func charType(_ char:Character) -> CharType {
        let digit = CharacterSet.decimalDigits;
        if char >= "0" && char <= "9" {
            return .digit
        } else if char == "+" || char == "-" {
            return .sign
        } else if char == "." {
            return .dot
        } else if char == "e" || char == "E" {
            return .exp
        } else if char.isWhitespace {
            return .space
        } else {
            return .illegal
        }
    }
    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_14"
    }
}
