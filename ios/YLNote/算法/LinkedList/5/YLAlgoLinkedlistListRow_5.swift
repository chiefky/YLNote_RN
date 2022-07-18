//
//  YLAlgoLinkedlistListRow_5.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
 请你将两个数相加，并以相同形式返回一个表示和的链表。
 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 
 来源：力扣（LeetCode）
 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.

 示例 2：
 输入：l1 = [0], l2 = [0]
 输出：[0]
 
 示例 3：
 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
 链接：https://leetcode.cn/problems/add-two-numbers
 */
class YLAlgoLinkedlistListRow_5: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: 删除链表的倒数第 N 个结点：
    @objc func testMethod_1() {
        let linkList1 = LinkList()
        for i in [2,4,3] {
            linkList1.append(value: i)
        }
        
        let linkList2 = LinkList()
        for i in [5,6,4] {
            linkList2.append(value: i)
        }

        var head = addTwoNumbers(linkList1.first, linkList2.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }


    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard  l1 != nil  else {
            return l2
        }
        
        guard l2 != nil else {
            return l1
        }
        let preHead = ListNode(0)
        var current = preHead
        var tmp1 = l1, tmp2 = l2
        var ahead:Int = 0
        while tmp1 != nil || tmp2 != nil || ahead != 0 {
            let sum = (tmp1?.val ?? 0) + (tmp2?.val ?? 0) + ahead
            let val = sum % 10
            let node = ListNode(val)
            ahead = sum / 10
            current.next = node
            current = node
            tmp1 = tmp1?.next
            tmp2 = tmp2?.next
        }
        return preHead.next
        
    }
    


    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_5"
    }
}
