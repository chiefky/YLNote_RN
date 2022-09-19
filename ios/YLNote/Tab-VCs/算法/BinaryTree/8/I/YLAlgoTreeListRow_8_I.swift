//
//  YLAlgoTreeListRow_8_I.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 32 - I. 从上到下打印二叉树
 从上到下打印出二叉树的每个节点，同一层的节点按照从左到右的顺序打印。
 例如:
 给定二叉树: [3,9,20,null,null,15,7],

     3
    / \
   9  20
     /  \
    15   7
 返回：
 [3,9,20,15,7]

 链接：https://leetcode.cn/problems/cong-shang-dao-xia-da-yin-er-cha-shu-lcof
 */
class YLAlgoTreeListRow_8_I: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr1 = [3,9,20,nil,nil,15,7]
        let root = TreeNode.from(arr1, 0)
        let res = levelOrder(root)
        print("🌲：\(res)");

    }
    
    /// 时间复杂度：O(n)，空间复杂度：O(n）
    /// - Parameter root: root
    /// - Returns: []
    func levelOrder(_ root: TreeNode?) -> [Int] {
        guard let root = root else {
            return []
        }
        var res:[Int] = []
        var queue:[TreeNode] = [root]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            res.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        return res;
    }
    
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_8_I"
    }



}

