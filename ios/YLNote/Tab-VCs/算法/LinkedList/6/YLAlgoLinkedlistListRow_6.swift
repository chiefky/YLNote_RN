//
//  YLAlgoLinkedlistListRow_6.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 18. 删除链表的节点
 给定单向链表的头指针和一个要删除的节点的值，定义一个函数删除该节点。
 返回删除后的链表的头节点。
 注意：此题对比原题有改动
 
 示例 1:
 输入: head = [4,5,1,9], val = 5
 输出: [4,1,9]
 解释: 给定你链表中值为 5 的第二个节点，那么在调用了你的函数之后，该链表应变为 4 -> 1 -> 9.
 
 示例 2:
 输入: head = [4,5,1,9], val = 1
 输出: [4,5,9]
 解释: 给定你链表中值为 1 的第三个节点，那么在调用了你的函数之后，该链表应变为 4 -> 5 -> 9.
  

 说明：
 题目保证链表中节点的值互不相同
 若使用 C 或 C++ 语言，你不需要 free 或 delete 被删除的节点
 https://leetcode.cn/problems/shan-chu-lian-biao-de-jie-dian-lcof/
 */
class YLAlgoLinkedlistListRow_6: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: 删除链表中值为val的结点：
    @objc func testMethod_1() {
        let linkList1 = LinkList()
        for i in [-3,5,-99] {
            linkList1.append(value: i)
        }
        var head = deleteNode(linkList1.first, -99)
        var str = ""
        while head != nil {
            str = str + "\(head!.val)" + ","
            head = head?.next
        }
        print(str)
    }
    
    /// 时间复杂度：O(n),空间复杂度：O(1)
    /// - Parameters:
    ///   - head: head
    ///   - val: target
    /// - Returns: head
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        guard let head = head else { return head }
        if head.val == val { return head.next }
        var current:ListNode? = head.next
        var pre:ListNode? = head
        while current != nil , current?.val != val {
            pre = current
            current = current?.next
        }
        if current != nil { pre!.next = current?.next }
        return head
    }


    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_6"
    }
}
