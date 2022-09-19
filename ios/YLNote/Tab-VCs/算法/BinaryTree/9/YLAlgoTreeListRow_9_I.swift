//
//  YLAlgoTreeListRow_9_I.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 68 - I. 二叉搜索树的最近公共祖先
 给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。

 百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

 例如，给定如下二叉搜索树:  root = [6,2,8,0,4,7,9,null,null,3,5]
 示例 1:
 输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
 输出: 6
 解释: 节点 2 和节点 8 的最近公共祖先是 6。

 链接：https://leetcode.cn/problems/er-cha-sou-suo-shu-de-zui-jin-gong-gong-zu-xian-lcof

swift版链接： https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-search-tree/


 */
class YLAlgoTreeListRow_9_I: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @objc func testMethod_1(){
        let root = TreeNode.from([6,2,8,0,4,7,9,nil,nil,3,5], 0)
        let p = TreeNode(2)
        let q = TreeNode(8)
        let res = lowestCommonAncestor_twice(root, p, q)
        print("🍎：\(res)")

    }
    func lowestCommonAncestor_twice(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        let p_path = lookforPath(root, p);
        let q_path = lookforPath(root, q);
        let p_leghth = p_path.count, q_length = q_path.count;
        let size = min(p_leghth, q_length)
        for i in 0..<size {
            if p_path[i].val != q_path[i].val {
                return p_path[i-1]
            }
        }
        return nil
    }

    func lookforPath(_ root:TreeNode?,_ target:TreeNode?) -> [TreeNode] {
        guard let root = root,let target = target else {
            return []
        }
        var res:[TreeNode] = []
        var current:TreeNode? = root
        while let cur = current {
            if cur.val == target.val {
                res.append(cur)
                return res
            } else if cur.val > target.val {
                res.append(cur)
                current = cur.left
            } else {
                res.append(cur)
                current = cur.right
            }
        }

        return res
    }
    
    @objc func testMethod_2(){
        let root = TreeNode.from([6,2,8,0,4,7,9,nil,nil,3,5], 0)
        let p = TreeNode(2)
        let q = TreeNode(8)
        let res = lowestCommonAncestor_single(root, p, q)
        print("🍎：\(res)")

    }
    
    func lowestCommonAncestor_single(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let r = root,let p = p, let q = q else { return nil }
        var current:TreeNode? = r
        while let cur = current {
            if cur.val > p.val && cur.val > q.val {
                current = cur.left
            } else if cur.val < p.val && cur.val < q.val {
                current = cur.right
            } else {
                return cur;
            }
        }
        return nil
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_9_I"
    }


}
