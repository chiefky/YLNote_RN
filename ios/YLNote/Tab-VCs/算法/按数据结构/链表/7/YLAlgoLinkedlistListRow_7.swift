//
//  YLAlgoLinkedlistListRow_7.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 - 7、剑指 Offer 52. 两个链表的第一个公共节点

 输入两个链表，找出它们的第一个公共节点。

 如下面的两个链表：
 https://leetcode.cn/problems/liang-ge-lian-biao-de-di-yi-ge-gong-gong-jie-dian-lcof/
 */
class YLAlgoLinkedlistListRow_7: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let linkList1 = LinkList()
        for i in [1,2,3] {
            linkList1.append(value: i)
        }
        
        let linkList2 = LinkList()
        for i in [7,8,9] {
            linkList2.append(value: i)
        }
        
        let sharedList = LinkList()
        for i in [4,5] {
            sharedList.append(value: i)
        }
        
        linkList1.last?.next = sharedList.first
        linkList2.last?.next = sharedList.first

        let res = getIntersectionNode(linkList1.first, linkList2.first)
        print("公共节点：\(res?.val)")
    }
    
    
    /// 双指针
    /// 空间复杂度：O(a+b)；时间复杂度：O(1）
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
            if headA == nil || headB == nil {return nil }
            var ha = headA, hb = headB
            while ha !== hb {
               ha = ha != nil ? ha?.next : headB
               hb = hb != nil ? hb?.next : headA
            }
            return ha
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_7"
    }
}
