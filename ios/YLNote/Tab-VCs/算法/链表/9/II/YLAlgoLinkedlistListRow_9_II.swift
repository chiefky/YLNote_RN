//
//  YLAlgoLinkedlistListRow_9_II.swift
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
class YLAlgoLinkedlistListRow_9_II: YLBaseTableViewController {
    
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
        
        let res = detectCycle(linkList1.first)
        print("存在环入口:\(res?.val ?? 0)")
    }
    
    /// 快慢指针（龟兔赛跑算法）
    /// 时间复杂度：O(n)；空间复杂度：O(1)
    /// 设：head到环入口的距离是a，环的长度是b，fast = head; slow = head;
    /// fast以2倍速前进，slow以1倍速前进；在第一次相遇点，fast走了f步，slow走了s步；
    /// 则有 f = 2s; f = s + nb; ==> s = nb;
    /// 此时slow 再继续走a步（即：s = nb+a）必然到达入口点；
    /// 此时如果让fast从head位置以1倍速前进，二者必然会相遇(即fast==slow)
    /// 最后输出fast节点即可
    func detectCycle(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        var slow:ListNode? = head,fast:ListNode? = head;
        while true {
            if fast == nil || fast?.next == nil {
                return nil
            }
            slow = slow?.next;
            fast = fast?.next?.next;
            if slow === fast {
                break;// 第一次相遇
            }
        }
        
        fast = head;
        while fast !== slow {
            slow = slow?.next;
            fast = fast?.next;
        }
        // 第二次相遇
        return fast
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_9_II"
    }
}
