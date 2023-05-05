//
//  YLAlgoTreeListRow_0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 104. 二叉树的最大深度

 给定一个二叉树，找出其最大深度。

 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
 说明: 叶子节点是指没有子节点的节点。

 示例：
 给定二叉树 [3,9,20,null,null,15,7]，

 链接：https://leetcode.cn/problems/maximum-depth-of-binary-tree
 */
class YLAlgoTreeListRow_0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let root = TreeNode.from([3,9,20,nil,nil,15,7], 0)
        let res = depth_recursion(root)
        print("🍎：\(res)")
    }
    
    @objc func testMethod_2() {
        let root = TreeNode.from([1,2,3,4,nil,nil,5], 0)
        let res = deepth_BFS(root)
        print("🍎：\(res)")
    }
    
    /// 递归
    func depth_recursion(_ root:TreeNode?) -> Int {
        guard let r = root else { return 0 }
        let left = depth_recursion(r.left)
        let right = depth_recursion(r.right)
        return 1 + max(left, right)
    }
    
    /// 层次遍历（广度优先搜索）
    func deepth_BFS(_ root: TreeNode?) -> Int {
        guard let r = root else { return 0 }
        var res = 0
        var queue:[TreeNode] = [r]
        while !queue.isEmpty {
            var level_count = queue.count
            let level_nodes = transformToValues(queue)
            print("🌹\(res)：\(level_count),\(level_nodes)")
            while level_count > 0 {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
                level_count -= 1;
            }

            res += 1;
        }
        return res
    }
    
    func transformToValues(_ nodes:[TreeNode]) -> [Int] {
        return nodes.map{$0.val};
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_0"
    }

}

