//
//  YLAlgoTreeListRow_13.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 36. 二叉搜索树与双向链表
 输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的循环双向链表。要求不能创建任何新的节点，只能调整树中节点指针的指向。
 链接：https://leetcode.cn/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/?favorite=xb9nqhhg
 */
class YLAlgoTreeListRow_13: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var pre:Node? = nil
    var head:Node? = nil
    
    @objc func testMethod_1() {
        let A = Node.from([4,2,5,1,3],0)
        let res = treeToDoublyList(A)
        print("🌲：\(res)");
    }
    
    /// 二叉搜索树转双向链表（递归）
    /// 时间复杂度：O(n）空间复杂度：O(N)
    /// - Parameter root: 根节点
    /// - Returns: head
    func treeToDoublyList(_ root: Node?) -> Node? {
        guard let root = root else {
            return nil
        }
        dfs_List(root)
        head?.left = pre
        pre?.right = head
        return head
    }
    
    /// 二叉树的中序遍历
    /// - Parameter root: 根节点
    func dfs_List(_ root:Node?) {
        guard let cur = root else { return  }
        dfs_List(cur.left)
        if pre != nil {
            pre?.right = cur
        } else {
            head = cur
        }
        cur.left = pre
        pre = cur
        dfs_List(cur.right)
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_13"
    }

}

