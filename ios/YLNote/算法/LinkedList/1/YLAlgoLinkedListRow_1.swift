//
//  YLAlgoLinkedListRow_1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoLinkedListRow_1: YLBaseTableViewController {

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

    /// 双指针
    /// - Parameter head: 原链表的head
    /// - Returns: 反转后的head
    func method_1(_ head:ListNode?) -> ListNode? {
        var new_head:ListNode? = nil
        var current = head
        while current != nil {
            let tmp = current!.next
            current!.next = new_head
            new_head = current
            current = tmp
        }
        return new_head
    }
    
    /// 两两交换
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
        return "Algo_list_row_1"
    }
}
