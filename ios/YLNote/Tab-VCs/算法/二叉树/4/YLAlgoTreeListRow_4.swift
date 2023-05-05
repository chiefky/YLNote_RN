//
//  YLAlgoTreeListRow_4.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 101. 对称二叉树
 给你一个二叉树的根节点 root ， 检查它是否轴对称。
 https://leetcode.cn/problems/symmetric-tree/
 */
class YLAlgoTreeListRow_4: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let root = TreeNode.from([1,2,2,3,4,4,3], 0);
        let res = method_1(root)
        
        print("\(res)");

    }

    @objc func testMethod_2() {
        let root = TreeNode.from([1,2,2,3,4,4,5], 0);
        let res = method_2(root)
        
        print("\(res)");

    }
    
    /// 递归 时间复杂度：O(n)，空间复杂度：O(h)； h: 二叉树深度
    func method_1(_ root: TreeNode?) -> Bool {
        return check(root?.left, root?.right)
        
    }
    func check(_ r1:TreeNode?,_ r2:TreeNode?) -> Bool {
        if r1 == nil, r2 == nil {
            return true
        }
        guard let r1 = r1,let r2 = r2 else { return false }
        print("\(r1.val)-\(r2.val)")
        if r1.val != r2.val {
            return false
        }
        let res1 = check(r1.left, r2.right)
        let res2 = check(r1.right, r2.left)
        return res1 && res2
    }
    
    /// 迭代 时间复杂度：O(n)，空间复杂度：O(1)
    /// - Parameter root: <#root description#>
    /// - Returns: <#description#>
    func method_2(_ root: TreeNode?) -> Bool {
        if root?.left == nil ,root?.right == nil {
            return true
        }
        guard let left = root?.left,let right = root?.right else { return false }
        var queue:[TreeNode] = []
        queue.append(left)
        queue.append(right)
        while !queue.isEmpty {
            let n1 = queue.removeFirst()
            let n2 = queue.removeFirst()
            if  n1.val != n2.val {
                return false
            }
            
            if n1.left != nil, n2.right != nil {
                queue.append(n1.left!)
                queue.append(n2.right!)
            } else if n1.left != nil || n2.right != nil {
                return false
            }
            
            if n1.right != nil, n2.left != nil {
                queue.append(n1.right!)
                queue.append(n2.left!)
            } else if n1.right != nil || n2.left != nil {
                return false
            }

        }
        
        return true
    }
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_4"
    }



}

