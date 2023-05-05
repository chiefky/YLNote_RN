//
//  YLAlgoLinkedlistListRow_3.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 19. 删除链表的倒数第 N 个结点
 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
 示例1：
 输入：head = [1,2,3,4,5], n = 2
 输出：[1,2,3,5]
 https://leetcode.cn/problems/remove-nth-node-from-end-of-list/
 */
class YLAlgoLinkedlistListRow_3: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: 删除链表的倒数第 N 个结点：
    @objc func testMethod_1() {
        let linkList = LinkList()
        for i in [1,2] {
            linkList.append(value: i)
        }
        
        var head = method_1(linkList.first, n: 2)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }


    func method_1(_ head: ListNode?,n: Int) -> ListNode? {
        guard let head = head else { return nil }
        var fast:ListNode? = head,slow:ListNode? = head;
        var new_head:ListNode? = slow 
        var offset = 0
        while fast?.next != nil {
            fast = fast?.next;
            offset += 1;
            if offset > n {
                slow = slow?.next
            }
        }
        if offset+1 == n {
            new_head = head.next
        } else {
            slow?.next = slow?.next?.next
        }
        return new_head;
    }


    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_3"
    }
}
