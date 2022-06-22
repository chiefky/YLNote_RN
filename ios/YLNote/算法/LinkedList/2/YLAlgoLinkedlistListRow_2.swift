//
//  YLAlgoLinkedlistListRow_2.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个头结点为 head 的非空单链表，返回链表的中间结点。
 如果有两个中间结点，则返回第二个中间结点。

 示例 1：
 输入：[1,2,3,4,5]
 输出：此列表中的结点 3 (序列化形式：[3,4,5])
 返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
 注意，我们返回了一个 ListNode 类型的对象 ans，这样：
 ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.
 示例 2：

 输入：[1,2,3,4,5,6]
 输出：此列表中的结点 4 (序列化形式：[4,5,6])
 由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。

 链接：https://leetcode.cn/problems/middle-of-the-linked-list
 */
class YLAlgoLinkedlistListRow_2: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let linkList = LinkList()
        for i in [1,2,3,4,5] {
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

    func method_1(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        var fast:ListNode? = head; //每次走两步
        var slow:ListNode? = head; // 每次走一步
        while fast?.next != nil {
            let tmp = fast?.next
            fast = tmp?.next
            slow = slow?.next
        }
        return slow
    }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_2"
    }
}
