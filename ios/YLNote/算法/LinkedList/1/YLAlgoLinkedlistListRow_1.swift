//
//  YLAlgoLinkedlistListRow_1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 定义一个函数，输入一个链表的头节点，反转该链表并输出反转后链表的头节点。
示例:
 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/fan-zhuan-lian-biao-lcof
 */
class YLAlgoLinkedlistListRow_1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: 反转链表：    
    @objc func testMethod_1() {
        let linkList = LinkList()
        for i in [5,8,9,0] {
            linkList.append(value: i)
        }
        
        var head = method_1(linkList.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }

    @objc func testMethod_2() {
        let linkList = LinkList()
        for i in [5,8,9,0] {
            linkList.append(value: i)
        }
        
        var head = method_2(linkList.first)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }

    /// 头插法 （关键节点是current；在current位置断开，分裂成两个链表）初始化一个新的空节点，从旧的链表上摘除节点插入到新的链表的new_head位置；
    /// - Parameter head: 原链表的head
    /// - Returns: 反转后的head
    func method_1(_ head:ListNode?) -> ListNode? {
        var new_head:ListNode? = nil
        var current = head
        while current != nil {
            let tmp = current!
            current = current!.next
            tmp.next = new_head
            new_head = tmp
        }
        return new_head
    }
    
    /// 两两交换 （关键节点是current.next；在原来的链表里修改指针的指向，修改完指针指向将新的头结点赋值）
    /// - Parameter head:
    /// - Returns:
    func method_2(_ head: ListNode?) -> ListNode? {
        var new_head = head
        let current = head
        while current?.next != nil {
            let tmp = current!.next
            current!.next = tmp?.next;
            tmp?.next = new_head
            new_head = tmp
        }
        
        return new_head
    }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_1"
    }
}
