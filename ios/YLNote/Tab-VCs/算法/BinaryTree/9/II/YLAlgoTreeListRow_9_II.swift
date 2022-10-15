//
//  YLAlgoTreeListRow_9_II.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 236. 二叉树的最近公共祖先
 给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。

 百度百科中最近公共祖先的定义为：“对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

 链接：https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-tree/description/
 */
class YLAlgoTreeListRow_9_II: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1(){
        let root = TreeNode.from([3,9,20,nil,nil,15,7], 0)
        let p = TreeNode(5)
        let q = TreeNode(1)
        let res = lowestCommonAncestor(root, p, q)
        print("🍎：\(res)")

    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root,let p = p,let q = q  else { return nil }
        if p.val == root.val || q.val == root.val {
            return root
        }
        let l_root = lowestCommonAncestor(root.left, p, q)
        let r_root = lowestCommonAncestor(root.right, p, q)
        return l_root == nil ? r_root : (r_root == nil ? l_root : root)
        
    }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_9_II"
    }


}
