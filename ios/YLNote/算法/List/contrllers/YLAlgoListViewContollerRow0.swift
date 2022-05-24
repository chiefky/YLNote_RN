//
//  YLAlgoListViewContollerRow0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoListViewContollerRow0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:  从尾到头打印链表：
    /// 往数组头0位置插入
    @objc func testPrintListFromTailToHead1() {
        let linkList = LinkList()
        for i in 1...4 {
            linkList.append(value: i)
        }

        let res = printListFromTailToHead(linkList.first);
        print("\(res)")
    }
    
    func printListFromTailToHead ( _ head: ListNode?) -> [Int] {
        // write code here
        if head == nil {
            return []
        }
        
        var res = [Int]()
        var tmpNode:ListNode? = head!
        while (tmpNode != nil) {
            let tmpVal = tmpNode!.val
            res.insert(tmpVal, at: 0)
            tmpNode = tmpNode?.next
        }
        return res
        
    }
    
    /// 递归
    @objc func testPrintListFromTailToHead2() {
        let linkList = LinkList()
        for i in 1...4 {
            linkList.append(value: i)
        }

        var res:[Int] = []
        receure(linkList.first, res: &res)
        print("\(res)")
    }
    func receure(_ node:ListNode?, res: inout [Int]) {
        if node == nil {
            return;
        }
        receure(node?.next, res: &res)
        res.append(node!.val)
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_list_row_0"
    }


}
