//
//  YLAlgoTreeListRow_15.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 230. 二叉搜索树中第K小的元素
 给定一个二叉搜索树的根节点 root ，和一个整数 k ，请你设计一个算法查找其中第 k 个最小元素（从 1 开始计数）。
 链接： https://leetcode.cn/problems/kth-smallest-element-in-a-bst/description/
 */
class YLAlgoTreeListRow_15: YLBaseTableViewController {
   
    var cur_index = 0
    var res = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: 递归
    @objc func testMethod_recursive() {
        let A = TreeNode.from([5,3,6,2,4,nil,nil,1],0)
        let res = kthLargest(A, 3)
        print("🌲serialize：\(res)");
    }
    
    /// 二叉搜索树的第K小节点值
    /// - Parameters:
    ///   - root: 根节点
    ///   - k: 序号
    /// - Returns: 目标节点值
    func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        
        dfs_order_kthLargest(root, k)
        return res
        
    }
    
    /// 中序遍历 (时间复杂度：O(n),空间复杂度：O(h)）
    /// - Parameters:
    ///   - root: root
    ///   - k: k
    func dfs_order_kthLargest(_ root:TreeNode?, _ k: Int)  {
        if let root = root {
            print("-----🌹：\(root.val)")
            dfs_order_kthLargest(root.left, k)
            cur_index += 1
            print("\(cur_index): \(root.val)");
            if cur_index > k {
                return;
            }
            res = root.val
            dfs_order_kthLargest(root.right, k)
        }
    }
    
    @objc func testMethod_iterator() {
        let A = TreeNode.from([5,3,6,2,4,nil,nil,1],0)
        let res = iterator_order_kthLargest(A, 3)
        print("🌲serialize：\(res)");
    }
    
    /// 迭代实现中序遍历（时间复杂度：O(k)，空间复杂度：O(n));
    /// - Parameters:
    ///   - root: root
    ///   - k: k
    /// - Returns: result
    func iterator_order_kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        var index = k;
        var stack:[TreeNode] = []
        var node = root
        while !stack.isEmpty || node != nil {
            while let n = node {
                stack.append(n);
                node = n.left;
            }

            if !stack.isEmpty {
                let last = stack.removeLast();
                index -= 1;
                if index == 0 {
                    return last.val;
                }
                node = last.right
            }
        }
        return 0
    }
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_15"
    }

}

