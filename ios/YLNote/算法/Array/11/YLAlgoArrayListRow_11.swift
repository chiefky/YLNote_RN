//
//  YLAlgoArrayListRow_11.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
 说明：本题中，我们将空字符串定义为有效的回文串。
 链接：https://leetcode.cn/problems/valid-palindrome/
*/

class YLAlgoArrayListRow_11: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        
        let str = "0P"//"A man, a plan, a anal: Panama";
        let res = method_1(str)
        print("结果：\(res)")
    }
    
    @objc func testMethod_2() {
        
        let str = "race a car"//"A man, a plan, a anal: Panama";
        let res = method_2(str)
        print("结果：\(res)")
    }
    
    /// 过滤有效字符后，对半比较（注意：字符串按下标取字符’s[s.index(s.startIndex, offsetBy: r)]‘容易造成超时，优化成数组取值）
    /// - Parameter s: <#s description#>
    /// - Returns: <#description#>
    func method_1(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        let valid_str = s.filter { $0.isNumber || $0.isLetter };
        let chars = Array(valid_str.lowercased())
        for i in 0..<chars.count/2 {
            let l_char = chars[i]
            let r_char = chars[chars.count-1-i]
            if l_char != r_char {
                return false
            }
        }
        return true
    }
    
    func method_2(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        func isCharOrNum(_ char: Character) -> Bool {
            return char.isLetter || char.isNumber;
        }
        let chars = Array(s);
        var l = 0
        var r = s.count-1
        while l<r {
            while l<r && !isCharOrNum(chars[r]) {
                r -= 1;
            }
            while l<r && !isCharOrNum(chars[l]) {
                l += 1;
            }
            if chars[l].lowercased() != chars[r].lowercased() {
                return false
            }
            l += 1;
            r -= 1;
        }
        return true
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_11"
    }

}
