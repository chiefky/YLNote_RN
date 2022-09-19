//
//  YLAlgoTreeListRow_9_II.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给定一个二叉树，判断它是否是高度平衡的二叉树。
 本题中，一棵高度平衡二叉树定义为：
 一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1 。

 示例 1：
 输入：root = [3,9,20,null,null,15,7]
 输出：true
 https://leetcode.cn/problems/balanced-binary-tree/

 */
class YLAlgoTreeListRow_9_II: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1(){
        let root = TreeNode.from([3,9,20,nil,nil,15,7], 0)
        let res = method_recursion(root)
        print("🍎：\(res)")

    }
    
    func method_recursion(_ root:TreeNode?) -> Bool {
        guard let r = root else { return true }
        let deepth_left = depth_recursion(r.left)
        let deepth_right = depth_recursion(r.right)
        return (abs(deepth_right - deepth_left) <= 1) && method_recursion(r.left) && method_recursion(r.right)
    }
    
    func depth_recursion(_ root: TreeNode?) -> Int {
        guard let r = root else { return 0 }
        let left = depth_recursion(r.left)
        let right = depth_recursion(r.right)
        return 1 + max(left, right)
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_9_II"
    }


}
