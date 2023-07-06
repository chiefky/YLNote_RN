//
//  YLAlgoLinkedlistListRow_9_I.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 141. 环形链表
 给你一个链表的头节点 head ，判断链表中是否有环。

 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。注意：pos 不作为参数进行传递 。仅仅是为了标识链表的实际情况。

 如果链表中存在环 ，则返回 true 。 否则，返回 false 。
 
 */
class YLAlgoLinkedlistListRow_9_I: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: 两两交换链表中的节点：
    @objc func testMethod_1() {
        let linkList1 = LinkList()
        for i in [1,2,3,4] {
            linkList1.append(value: i)
        }
        linkList1.last?.next = linkList1.first?.next
        
        let res = hasCycle(linkList1.first)
        print("是否存在环?:\( res==true ? "是":"否")")
    }
    
    /// 快慢指针（龟兔赛跑算法）
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil ||  head?.next == nil {
            return false;
        }
        var slow = head, fast = head?.next
        while slow !== fast {
            if fast == nil || fast?.next == nil {
                return false;
            }
            slow = slow?.next
            fast = fast?.next?.next;
        }
        return true
        
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_9_1"
    }
}
