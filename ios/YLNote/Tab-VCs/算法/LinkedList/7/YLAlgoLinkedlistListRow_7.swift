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


 */
class YLAlgoLinkedlistListRow_7: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let linkList1 = LinkList()
        for i in [-3,5,-99] {
            linkList1.append(value: i)
        }
//        var head = deleteNode(linkList1.first, -99)
//        var str = ""
//        while head != nil {
//            str = str + "\(head!.val)" + ","
//            head = head?.next
//        }
//        print(str)
    }
    
  

    //    MARK: override
    override func fileName() -> String {
        return "Algo_linkedlist_list_row_7"
    }
}
