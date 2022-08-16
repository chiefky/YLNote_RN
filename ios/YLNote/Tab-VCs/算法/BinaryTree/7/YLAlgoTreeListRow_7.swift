//
//  YLAlgoTreeListRow_7.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 27. 二叉树的镜像
 请完成一个函数，输入一个二叉树，该函数输出它的镜像。
 
 示例 1：
 输入：root = [4,2,7,1,3,6,9]
 输出：[4,7,2,9,6,3,1]
  
 https://leetcode.cn/problems/er-cha-shu-de-jing-xiang-lcof/
 */
class YLAlgoTreeListRow_7: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr1 = [4,2,7,1,3,6,9]
        let pre = TreeNode.from(arr1, 0)
        let root = mirrorTree(pre)
        var queue:[TreeNode] = [root!]
        var arr:[Int] = []
        while !queue.isEmpty {
            var level_count = queue.count
            while level_count > 0 {
                let node = queue.removeFirst()
                arr.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
                level_count -= 1;
            }

        }

        print("🌲：\(arr)");

    }
    
    @objc func testMethod_2() {
        let arr1 = [4,2,7,1,3,6,9]
        let pre = TreeNode.from(arr1, 0)
        let root = mirrorTree_stack(pre)
        var queue:[TreeNode] = [root!]
        var arr:[Int] = []
        while !queue.isEmpty {
            var level_count = queue.count
            while level_count > 0 {
                let node = queue.removeFirst()
                arr.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
                level_count -= 1;
            }

        }

        print("🌲：\(arr)");

    }

    /// 递归
    /// 时间复杂度：O(n）
    /// 空间复杂度：O(n)
    /// - Parameter root: <#root description#>
    /// - Returns: <#description#>
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        let tmp = root.left
        root.left = mirrorTree(root.right)
        root.right = mirrorTree(tmp)
        return root
    }
    
    
    /// 借助栈
    /// 时间复杂度：O(n)
    /// 空间复杂度：O(n)
    /// - Parameter root: <#root description#>
    /// - Returns: <#description#>
    func mirrorTree_stack(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        var stack:[TreeNode] = [root];
        while !stack.isEmpty {
            let top = stack.removeLast()
            print("🌹：\(top.val)");
            if let left = top.left {
                stack.append(left)
            }
            if let right = top.right {
                stack.append(right)
            }
            let tmp = top.left
            top.left = top.right
            top.right = tmp
        }
        return root
    }


    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_7"
    }



}

