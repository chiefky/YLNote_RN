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
    
func testLinkList() {
    let linkList = LinkList()
    for i in 1...4 {
        linkList.append(value: i)
    }
    let res = linklist_qes_0(linkList.first)
    print("⛓结果：\(res) ");
}
