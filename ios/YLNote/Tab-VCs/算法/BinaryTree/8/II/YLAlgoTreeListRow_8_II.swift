//
//  YLAlgoTreeListRow_8_II.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 32 - II. 从上到下打印二叉树 II
 从上到下按层打印二叉树，同一层的节点按从左到右的顺序打印，每一层打印到一行。

 例如:
 给定二叉树: [3,9,20,null,null,15,7],

 https://leetcode.cn/problems/cong-shang-dao-xia-da-yin-er-cha-shu-ii-lcof/
 */
class YLAlgoTreeListRow_8_II: YLBaseTableViewController {
   

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
    /// - Returns: [[]]
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var res:[[Int]] = []
        var queue:[TreeNode] = [root]
        while !queue.isEmpty {
            var level_nodes_count = queue.count
            var level_nodes:[Int] = []
            while level_nodes_count > 0 {
                let node = queue.removeFirst()
                level_nodes.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
                level_nodes_count -= 1
            }
            res.append(level_nodes)
        }
        return res;
    }
    
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_8_II"
    }



}

