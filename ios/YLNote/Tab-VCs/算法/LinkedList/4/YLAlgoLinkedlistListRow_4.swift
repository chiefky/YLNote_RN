//
//  YLAlgoLinkedlistListRow_4.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 将两个升序链表合并为一个新的 升序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。

 示例 1：
 输入：l1 = [1,2,4], l2 = [1,3,4]
 输出：[1,1,2,3,4,4]
 
 示例 2：
 输入：l1 = [], l2 = []
 输出：[]
 
 示例 3：
 输入：l1 = [], l2 = [0]
 输出：[0]

 链接：https://leetcode.cn/problems/merge-two-sorted-lists
 */
class YLAlgoLinkedlistListRow_4: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let linkList1 = LinkList()
        for i in [1,2] {
            linkList1.append(value: i)
        }
        
        let linkList2 = LinkList()
        for i in [4,6] {
            linkList2.append(value: i)
        }

        var head = mergeTwoLists_recursion(linkList1.first, linkList2.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }

    @objc func testMethod_2() {
        let linkList1 = LinkList()
        for i in [1,2] {
            linkList1.append(value: i)
        }
        
        let linkList2 = LinkList()
        for i in [4,6] {
            linkList2.append(value: i)
        }

        var head = mergeTwoLists(linkList1.first, linkList2.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }
    
    /// 递归
    /// 时间复杂度：O(n+m)，
    /// 空间复杂度：O(n+m)
    /// - Parameters:
    ///   - list1: <#list1 description#>
    ///   - list2: <#list2 description#>
    /// - Returns: <#description#>
    func mergeTwoLists_recursion(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil {
            return list2
        } else if list2 == nil {
            return list1
        } else if list1!.val < list2!.val {
            list1?.next = mergeTwoLists_recursion(list1?.next, list2)
            return list1
        } else {
            list2?.next = mergeTwoLists_recursion(list1, list2?.next)
            return list2
        }

    }
    
    /// 迭代
    /// 时间复杂度：O(n+m)，
    /// 空间复杂度：O(1)
    /// - Parameters:
    ///   - l1: <#l1 description#>
    ///   - l2: <#l2 description#>
    /// - Returns: <#description#>
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else { return l2 }
        guard let l2 = l2 else { return l1 }
        let preHead:ListNode = ListNode(-1);
        var tail: ListNode? = preHead
        var node1:ListNode? = l1,node2:ListNode? = l2
        while node1 != nil, node2 != nil {
            if node1!.val <= node2!.val {
                tail?.next = node1
                node1 = node1!.next
            } else {
                tail?.next = node2
                node2 = node2!.next
            }
            tail = tail?.next
        }
        
        if node1 != nil {
            tail?.next = node1
        } else {
            tail?.next = node2
        }
        return preHead.next
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_4"
    }
}
