//
//  YLAlgoStackListRow_1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 31. 栈的压入、弹出序列
 输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。例如，序列 {1,2,3,4,5} 是某栈的压栈序列，序列 {4,5,3,2,1} 是该压栈序列对应的一个弹出序列，但 {4,3,5,1,2} 就不可能是该压栈序列的弹出序列。

 示例 1：
 输入：pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
 输出：true
 解释：我们可以按以下顺序执行：
 push(1), push(2), push(3), push(4), pop() -> 4,
 push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
 
 示例 2：
 输入：pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
 输出：false
 解释：1 不能在 2 之前弹出。
 https://leetcode.cn/problems/zhan-de-ya-ru-dan-chu-xu-lie-lcof/
 */
class YLAlgoStackListRow_1: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
        let res = validateStackSequences(pushed, popped);
        print("🍎结果:",res)
    }
    
    /// 时间复杂度：O(n)；空间复杂度：O(n)
    /// - Parameters:
    ///   - pushed: []
    ///   - popped: []
    /// - Returns: 按照poped顺序，是否能完全出栈。
    func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
           var stack:[Int] = [];
           var i = 0
           for num in pushed {
               stack.append(num)
               while i < popped.count ,popped[i] == stack.last {
                   stack.popLast()
                   i += 1
               }
           }
           return stack.isEmpty
    }
   
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_stack_row_1"
    }
    
}
