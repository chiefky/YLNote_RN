//
//  YLAlgoLinkedlistListRow_0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 输入一个链表的头节点，从尾到头反过来返回每个节点的值（用数组返回）。

 示例 1：
 输入：head = [1,3,2]
 输出：[2,3,1]
 
 限制： 0 <= 链表长度 <= 10000
 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/cong-wei-dao-tou-da-yin-lian-biao-lcof
 */
class YLAlgoLinkedlistListRow_0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:  从尾到头打印链表：
    @objc func testMethod_1() {
        let linkList = LinkList()
        for i in 1...4 {
            linkList.append(value: i)
        }

        let res = method_1(linkList.first)
        print("🍎1：\(res)")
    }
    
    @objc func testMethod_2() {
        let linkList = LinkList()
        for i in 1...4 {
            linkList.append(value: i)
        }

        let res = method_2(linkList.first)
        print("🍎2：\(res)")
    }
    
    @objc func testMethod_3() {
        let linkList = LinkList()
        for i in 1...4 {
            linkList.append(value: i)
        }

        let res = method_3(linkList.first)
        print("🍎3：\(res)")
    }
    @objc func testMethod_4() {
        let linkList = LinkList()
        for i in [6,2,3,4] {
            linkList.append(value: i)
        }

        let res = method_4(linkList.first)
        print("🍎4：\(res)")
    }

    /// 头插法：往数组头0位置插入next Node
    /// - Parameter head:
    /// - Returns: <#description#>
    func method_1(_ head:ListNode?) -> [Int] {
        var res:[Int] = []
        var cur = head
        while cur != nil {
            res.insert(cur!.val, at: 0)
            cur = cur!.next
        }
        return res
    }
    //    数组反序
    func method_2(_ head: ListNode?) -> [Int] {
        var stack:[Int] = []
        var cur = head
        while cur != nil {
            stack.append(cur!.val)
            cur = cur?.next
        }
        return stack.reversed()
    }
    
    /// 递归
    func method_3(_ head: ListNode?) -> [Int] {
        var res:[Int] = []
        let cur = head
        if cur != nil {
            res = method_3(cur?.next)
            res.append(cur!.val)
        }
        return res
    }
    
    /// 反转链表
    /// - Parameter head:
    /// - Returns:
    func method_4(_ head: ListNode?) -> [Int] {
        guard let head = head else { return [] }
        var new_head = head, cur = head
        while cur.next != nil {
            let temp = cur.next!
            cur.next = temp.next
            temp.next = new_head
            new_head = temp
        }
        
        var reversed:[Int] = [new_head.val]
        var rev_next = new_head.next
        while rev_next != nil {
            reversed.append(rev_next!.val)
            rev_next = rev_next!.next
        }
        return reversed
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_0"
    }


}
