//
//  YLAlgoLinkedlistListRow_10.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer II 027. 回文链表
 给定一个链表的 头节点 head ，请判断其是否为回文链表。
 如果一个链表是回文，那么链表节点序列从前往后看和从后往前看是相同的。
 
 https://leetcode.cn/problems/aMhZSa/
 */
class YLAlgoLinkedlistListRow_10: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: LeetCode 剑指 Offer II 027. 回文链表
    @objc func testMethod_1() {
        let l1 = LinkList()
        for i in [1,0,0] {
            l1.append(value: i)
        }
        let res = isPalindrome(l1.first)
        
        print("⛓是否是回文链表：:",res)
    }
    
    func isPalindrome(_ head: ListNode?) -> Bool {
            let firstHalfEnd = findFirstHalfEnd(head)
            var secndHalfStart = reverseList(firstHalfEnd?.next)
            var head = head
            while secndHalfStart != nil {
                if secndHalfStart?.val != head?.val {
                    return false
                }
                secndHalfStart = secndHalfStart?.next;
                head = head?.next
            }
            return true
        }
    
        // 快慢指针查找对称中点
        func findFirstHalfEnd(_ head:ListNode?) -> ListNode? {
            var fast = head,slow = head
            while fast?.next != nil && fast?.next?.next != nil {
                fast = fast?.next?.next
                slow = slow?.next
            }
            return slow
        }
        
        // 头插法 反转链表
         func reverseList(_ head: ListNode?) -> ListNode? {
            guard let head = head else {return nil}
            var preNode:ListNode?
            var currNode:ListNode? = head
            while currNode != nil {
                let nextNode = currNode?.next
                currNode?.next = preNode
                preNode = currNode
                currNode = nextNode
            }
            return preNode;
        }

    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_10"
    }
}
