//
//  YLAlgoTreeListRow_12.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 34. 二叉树中和为某一值的路径
 给你二叉树的根节点 root 和一个整数目标和 targetSum ，找出所有 从根节点到叶子节点 路径总和等于给定目标和的路径。
 叶子节点 是指没有子节点的节点。
 
 链接：https://leetcode.cn/problems/er-cha-shu-zhong-he-wei-mou-yi-zhi-de-lu-jing-lcof/description/?favorite=xb9nqhhg
 */
class YLAlgoTreeListRow_12: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var list:[[Int]] = []
    var path:[Int] = []
    @objc func testMethod_1() {
        let A = TreeNode.from([5,4,8,11,nil,13,4,7,2,nil,nil,nil,nil,5,1],0)
        let res = pathSum(A, 22)
        print("🌲：\(res)");
    }

    func pathSum(_ root: TreeNode?, _ target: Int) -> [[Int]] {
        guard let r = root else { return [] }
        recursionNodeSum(r, target);
        return list;
    }

    /// 遍历节点求和
    /// - Parameters:
    ///   - node: 从root到node的path之和
    ///   - target: 遍历过程中的目标和
    func recursionNodeSum(_ node:TreeNode?, _ target: Int)  {
        guard let r = node else { return }
        path.append(r.val)
        let newTarget = target - r.val
        if newTarget == 0 && r.left == nil && r.right == nil {
            let tmp = Array(path)
            list.append(tmp)
        }
//        print("\(newTarget)🌹\(r.val): \(path)")
        recursionNodeSum(node?.left, newTarget)
        recursionNodeSum(node?.right, newTarget)
        path.removeLast()
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_12"
    }

}

