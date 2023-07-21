//
//  YLAlgoBFSListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

/// <#Description#>
class YLAlgoBFSListController: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: LeetCode
    // MARK: LeetCode
    
    
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode
    // MARK: LeetCode 7. 剑指 Offer 37. 序列化二叉树(BFS)
    @objc func bfs_serialize() {
        let A = [1,2,3,nil,nil,4,5]
        let root = TreeNode.from(A, 0)
        let res = bfs_serialize(root)
        print("\(String(describing: root?.val))序列化后：\(res)")
    }
    
    @objc func bfs_deserialize() {
        let A = [1,2,3,nil,nil,4,5]
        let root = TreeNode.from(A, 0)
        let str = bfs_serialize(root)
        let res = bfs_deserialize(str)
        print("\(str)反序列化后：\(res)")
    }
    
    /// BFS
    /// 时间复杂度 O(N) ： N 为二叉树的节点数，层序遍历需要访问所有节点，最差情况下需要访问 N+1 个 null ，总体复杂度为 O(2N+1)=O(N)。
    ///空间复杂度 O(N) ： 最差情况下，队列 queue 同时存储 (N+1)/2 个节点（或 N+1 个 null ），使用 O(N)；列表 res 使用 O(N) 。
    /// (N+1)/2 来源：设二叉树的深度为x， 第x层的节点数 = 2^(x-1);(注：层数从1开始)
    /// N 代表二叉树的节点数，则有 N = 2^(x) - 1
    ///  ====> 2^(x) = N + 1
    ///  ====> 2^(x-1) = (N+1)/2
    func bfs_serialize(_ root: TreeNode?) -> String {
        guard let root = root else {
            return "[]"
        }
        
        var queue: [TreeNode?] = [root]
        var result = "[\(root.val)"
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            
            if let left = node?.left {
                result += ",\(left.val)"
                queue.append(left)
            } else {
                result += ",null"
            }
            
            if let right = node?.right {
                result += ",\(right.val)"
                queue.append(right)
            } else {
                result += ",null"
            }
        }
        
        result += "]"
        return result
    }

    func bfs_deserialize(_ data: String) -> TreeNode? {
        var tmp = data;
        tmp.removeFirst();
        tmp.removeLast();
        var values:[String] = tmp.components(separatedBy: ",")
        guard let rootValue = Int(values.removeFirst()) else {
            return nil
        }
        
        let root = TreeNode(rootValue)
        var queue: [TreeNode] = [root]
        var isLeftChild = true
        
        for value in values {
            if let nodeValue = Int(value) {
                let node = TreeNode(nodeValue)
                if isLeftChild {
                    queue.first?.left = node
                } else {
                    queue.first?.right = node
                }
                queue.append(node)
            }
            
            if !isLeftChild {
                queue.removeFirst()
            }
            
            isLeftChild = !isLeftChild
        }
        
        return root
    }

    
    /// 102. 二叉树的层序遍历
    @objc func bfs_levelOrder() {
        let A = [1,2,3,nil,nil,4,5]
        let root = TreeNode.from(A, 0)
        let res = bfs_levelOrder(root)
        print("\(root?.val)序列化后：\(res)")
    }
    
    /// bfs
    /// 时间复杂度O(n)，空间复杂度：
    /// - Parameter root: 根节点
    /// - Returns: 层次遍历结果
    func bfs_levelOrder(_ root:TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var res:[[Int]] = []
        var leveNodes:[TreeNode] = [root]
        while leveNodes.count > 0 {
            let leveCount = leveNodes.count
            var levelVals:[Int] = []
            for _ in 0..<leveCount {
                let node = leveNodes.removeFirst()
                levelVals.append(node.val)
                if let left = node.left {
                    leveNodes.append(left)
                }
                if let right = node.right {
                    leveNodes.append(right)
                }
            }
            res.append(levelVals)
        }
        return res
    }

    // MARK: override
    override func fileName() -> String {
        return "Algo_BFS_list"
    }

    
}
