//
//  YLAlgoQueueListRow_0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**剑指 Offer 09. 用两个栈实现队列
 用两个栈实现一个队列。队列的声明如下，请实现它的两个函数 appendTail 和 deleteHead，分别完成在队列尾部插入整数和在队列头部删除整数的功能。(若队列中没有元素，deleteHead 操作返回 -1 )

 示例 1：
 输入：
 ["CQueue","appendTail","deleteHead","deleteHead"]
 [[],[3],[],[]]
 输出：[null,null,3,-1]
 
 示例 2：
 输入：
 ["CQueue","deleteHead","appendTail","appendTail","deleteHead","deleteHead"]
 [[],[],[5],[2],[],[]]
 输出：[null,-1,null,null,5,2]

 链接：https://leetcode.cn/problems/yong-liang-ge-zhan-shi-xian-dui-lie-lcof
 */
class YLAlgoQueueListRow_0: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let arr = [0,1,2,1], k = 1
        let res = ""
        print("🍎结果：\(res)")
    }

   
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_queue_row_0"
    }
    
}
