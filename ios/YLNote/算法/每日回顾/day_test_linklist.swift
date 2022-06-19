//
//  day_test_linklist.swift
//  YLNote
//
//  Created by tangh on 2022/6/19.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation

func testLinkList() {
    let linkList = LinkList()
    for i in 1...4 {
        linkList.append(value: i)
    }
    let res = linklist_method_qes_0(linkList.first)
    print("⛓结果：\(res) ");
}

func linklist_method_qes_0(_ head:ListNode?) -> [Int] {
    guard head != nil else {
        return []
    }
    var new_head = head,current = head;
    while current?.next != nil {
        let tmp = current?.next;
        current?.next = tmp?.next // 第2次错在 把current写成new_head，造成无限循环
        tmp?.next = new_head
        new_head = tmp
    }

    var res:[Int] = []
    while new_head != nil {
        res.append(new_head!.val)
        new_head = new_head?.next
    }
    return res
}

func linklist_method_qes_1(_ head:ListNode?) -> ListNode? {
    guard head != nil else {
        return head
    }
    
    var new_head:ListNode? = nil,current = head
    while current != nil {
        let tmp = current
        current = current?.next // 代码优化点：tmp指向current，current 后移，摘除的节点命名为tmp
        tmp?.next = new_head;
        new_head = tmp
    }
    
//    var i = new_head
//    var str = ""
//    while i != nil {
//        str += "\(i!.val)"
//        i = i?.next
//    }
//    print("头插法翻转：\(str)")
    return new_head
    
}
