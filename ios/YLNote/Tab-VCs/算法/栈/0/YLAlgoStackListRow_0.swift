//
//  YLAlgoStackListRow_0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 30. 包含min函数的栈
 定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的 min 函数在该栈中，调用 min、push 及 pop 的时间复杂度都是 O(1)。

 示例:
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.min();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.min();   --> 返回 -2.
  

 提示：
 各函数的调用总次数不超过 20000 次

 */
class YLAlgoStackListRow_0: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        var res:[String] = []
        let minStack = MinStack()
        for num in [-2,0,-3] {
            minStack.push(num)
            res.append("null")
        }
        
        let x = minStack.min()
        let str = x != Int.max ? "\(x)," : "null,";
        res.append(str)
        
        minStack.pop();
        res.append("null")

        let y = minStack.top();
        let y_str = y != Int.max ? "\(y)," : "null,";
        res.append(y_str)

        let z = minStack.min();
        let z_str = z != Int.max ? "\(z)" : "null";
        res.append(z_str)
        print("🍎结果:",res)
    }

   
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_stack_row_0"
    }
    
}
