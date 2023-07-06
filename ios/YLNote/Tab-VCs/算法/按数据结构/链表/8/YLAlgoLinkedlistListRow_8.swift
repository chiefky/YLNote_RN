//
//  YLAlgoLinkedlistListRow_8.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 24. 两两交换链表中的节点
 给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。
 https://leetcode.cn/problems/swap-nodes-in-pairs/
 */
class YLAlgoLinkedlistListRow_8: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: 两两交换链表中的节点：
    @objc func testMethod_1() {
        let linkList1 = LinkList()
        for i in [1,2,3,4] {
            linkList1.append(value: i)
        }
        var head = swapPairs(linkList1.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }
    
    /// 时间复杂度：O(n),空间复杂度：O(1)
    /// - Parameters:
    ///   - head: head
    ///   - val: target
    /// - Returns: head
    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard let _ = head else {return nil}
        let empty = ListNode(-1)
        empty.next = head
        var pre:ListNode? = empty
        while pre?.next != nil, pre?.next?.next != nil {
            let node1:ListNode? = pre?.next;
            let node2 = node1?.next;
            pre?.next = node2
            node1?.next = node2?.next
            node2?.next = node1
            pre = node1
        }
        return empty.next
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_8"
    }
}
