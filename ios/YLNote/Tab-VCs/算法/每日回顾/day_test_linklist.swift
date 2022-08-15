//
//  day_test_linklist.swift
//  YLNote
//
//  Created by tangh on 2022/6/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

//MARK: 0
func linklist_qes_0(_ head: ListNode?) -> [Int] {
    var res:[Int] = [];
    var new_head:ListNode? = nil,current = head
    while current != nil {
        let tmp = current
        current = current?.next
        tmp?.next = new_head
        new_head = tmp
    }
    
    var reversed = new_head
    while reversed != nil {
        res.append(reversed!.val)
        reversed = reversed?.next
    }
    return res
}

//MARK: 1
func linklist_qes_1(_ head: ListNode?) -> ListNode? {
    guard let _ = head else { return nil }
    var new_head:ListNode? = nil,current = head
    while current != nil {
        let tmp = current
        current = current?.next
        tmp?.next = new_head
        new_head = tmp
    }
    return new_head
}
    
//MARK: 4
func linklist_qes_4(_ head1:ListNode?,_ head2:ListNode?) -> ListNode? {
    guard let head1 = head1 else {
        return head2
    }
    
    guard let head2 = head2 else {
        return head1
    }
    
    if head1.val <= head2.val {
        head1.next = linklist_qes_4(head1.next, head2)
        return head1
    } else {
        head2.next = linklist_qes_4(head1, head2.next)
        return head2
    }
}

//MARK: test
func testLinkList() {
    let linkList1 = LinkList()
    for i in [1,2,4] {
        linkList1.append(value: i)
    }
    
    let linkList2 = LinkList()
    for i in [1,3,4] {
        linkList2.append(value: i)
    }

    var node = linklist_qes_4(linkList1.first, linkList2.first)
    var res = ""
    while node != nil {
        res += String(node!.val)
        res += node?.next == nil ? ".":"->"
        node = node?.next
    }
    print("⛓结果：\(res) ");
}
