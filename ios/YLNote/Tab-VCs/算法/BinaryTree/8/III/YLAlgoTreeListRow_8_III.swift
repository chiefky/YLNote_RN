//
//  YLAlgoTreeListRow_8_III.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 32 - III. 从上到下打印二叉树 III
 请实现一个函数按照之字形顺序打印二叉树，即第一行按照从左到右的顺序打印，第二层按照从右到左的顺序打印，第三行再按照从左到右的顺序打印，其他行以此类推。
 例如:
 给定二叉树: [3,9,20,null,null,15,7],

     3
    / \
   9  20
     /  \
    15   7
 
 返回其层次遍历结果：
 [
   [3],
   [20,9],
   [15,7]
 ]
  

 提示：
 节点总数 <= 1000
 https://leetcode.cn/problems/cong-shang-dao-xia-da-yin-er-cha-shu-iii-lcof/
 */
class YLAlgoTreeListRow_8_III: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr1 = [3,9,20,nil,nil,15,7]
        let root = TreeNode.from(arr1, 0)
        let res = levelOrder_reversed(root)
        print("🌲：\(res)");

    }
    
    @objc func testMethod_2() {
        let arr1 = [1,2,3,4,nil,nil,5]//[3,9,20,nil,nil,15,7]
        let root = TreeNode.from(arr1, 0)
        let res = levelOrder_queue_head_to_head(root)
        print("🌲：\(res)");

    }

    /// 层次遍历+逆序
    /// 时间复杂度：O(n)，空间复杂度：O(n）
    /// - Parameter root: root
    /// - Returns: [[]]
    func levelOrder_reversed(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var res:[[Int]] = []
        var queue:[TreeNode] = [root]
        var order = 0
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
            let tmp = order%2 == 0 ? level_nodes : level_nodes.reversed()
            res.append(tmp)
            order += 1
        }
        return res;

    }
    
    /// 层次遍历+双端队列
    /// 时间复杂度：O(n)，空间复杂度：O(n)
    /// - Parameter root: root
    /// - Returns: [[]]
    func levelOrder_queue_head_to_head(_ root:TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var res:[[Int]] = []
        
        var queue:[TreeNode] = [root]
        var level = 0
        
        while !queue.isEmpty {
            var level_nodes_count = queue.count
            var tmp:[Int] = []
            while level_nodes_count > 0 {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }

                if level%2==0 {
                    tmp.append(node.val)
                } else {
                    tmp.insert(node.val, at: 0)
                }
                level_nodes_count -= 1
            }
            res.append(tmp)
            print("level \(level):\(tmp)")
            level += 1;
        }
        return res
    }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_8_III"
    }



}

