//
//  YLAlfgoListViewContollerRow1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlfgoListViewContollerRow1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: 反转链表：
    
    /// 双指针
    @objc func testReverseList1() {
        let linkList = LinkList()
        for i in 1...4 {
            linkList.append(value: i)
        }
        
        var head = reverseList1(linkList.first)
        var str = ""
        
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }
    
    func reverseList1( _ head: ListNode?) -> ListNode? {
        // write code here
        if (head == nil) { return nil }
        var pre:ListNode? = nil
        var cur = head
        var tmp = cur
        
        while (cur != nil) {
            tmp = cur?.next
            cur!.next = pre
            pre = cur
            cur = tmp
        }
        
        return pre
    }
    
    
    /// 位置两两交换
    @objc func testReverseList2() {
        let linkList = LinkList()
        for i in 1...4 {
            linkList.append(value: i)
        }
        
        var head = reverseList1(linkList.first)
        var str = ""
    }
    
    /// 疑问：什么是下一个指向下一个，
    /// - Parameter head: <#head description#>
    /// - Returns: <#description#>
    func reverseList2( _ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        
        var cur = head!
        var top:ListNode? = head
        
        while cur.next != nil {
            var tmp = cur.next
            cur.next = tmp?.next
            tmp?.next = top
            top = tmp
        }
        
        return top
    }
    
    
    func reverseList3( _ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        var cur = head!
        var top:ListNode? = head
        
        while cur.next != nil {
            var tmp = cur.next
            cur.next = tmp?.next
            tmp?.next = top
            top = tmp
        }
        
        return top
    }

    //    MARK: override
    override func fileName() -> String {
        return "Alfgo_list_row_1"
    }
}
