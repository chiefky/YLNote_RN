//
//  YLAlgoStringListRow_12.swift
//  YLNote
//
//  Created by tangh on 2022/3/10.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 46. 把数字翻译成字符串

 给定一个数字，我们按照如下规则把它翻译为字符串：0 翻译成 “a” ，1 翻译成 “b”，……，11 翻译成 “l”，……，25 翻译成 “z”。一个数字可能有多个翻译。请编程实现一个函数，用来计算一个数字有多少种不同的翻译方法。

 https://leetcode.cn/problems/ba-shu-zi-fan-yi-cheng-zi-fu-chuan-lcof/
 */
class YLAlgoStringListRow_12: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let s1 = 1
        let res = translateNum(s1)
        print("🍎1：\(res)")
        
    }
    
    /// 动态规划
    /// 时间复杂度：O(n)，空间复杂度：O(n)
    func translateNum(_ num: Int) -> Int {
        let numStr = String(num)
        let n = numStr.count
        if n < 2 { return 1 }
        var dp:[Int] = Array(repeating: 0, count: n+1) // 存：前i个数有多少种翻译方法
        dp[0] = 1;
        dp[1] = 1;
        for i in 2...n {
            let preCharNum = numStr[numStr.index(numStr.startIndex, offsetBy: i-2)].wholeNumberValue ?? 0
            let curCharNum = numStr[numStr.index(numStr.startIndex, offsetBy: i-1)].wholeNumberValue ?? 0
            let tmp = preCharNum * 10 + curCharNum
            if tmp > 9 && tmp <= 25 {
                dp[i] = dp[i-1] + dp[i-2];
            } else {
                dp[i] = dp[i-1]
            }
        }
        
        return dp[n]
    }
    
    //MARK: override
    override func fileName() -> String {
        return "Algo_string_row_12"
    }
}
