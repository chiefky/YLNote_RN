//
//  YLAlgoTreeListRow_11.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 26. 树的子结构
 输入两棵二叉树A和B，判断B是不是A的子结构。(约定空树不是任意一个树的子结构)
 B是A的子结构， 即 A中有出现和B相同的结构和节点值。
 链接: https://leetcode.cn/problems/shu-de-zi-jie-gou-lcof/description/?favorite=xb9nqhhg
 */
class YLAlgoTreeListRow_11: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let A = TreeNode.from([1,0,1,-4,-3],0)
        let B = TreeNode.from( [1,-4], 0)
        let res = isSubStructure(A,B)
        print("🌲：\(res)");

    }
    
    /// 判断B树是不是A树的子树
    /// - Parameters:
    ///   - A: <#A description#>
    ///   - B: <#B description#>
    /// - Returns: <#description#>
    func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        guard let A = A,let B = B else {
            return false;
        }
        return recursionVerify(A, B) || isSubStructure(A.left, B) || isSubStructure(A.right, B)
    }
    
    /// 验证每个节点值是否一致
    /// - Parameters:
    ///   - A: <#A description#>
    ///   - B: <#B description#>
    /// - Returns: <#description#>
    func recursionVerify(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        if B == nil {
            return true;
        }
        if A == nil || A?.val != B?.val {
            return false;
        }
        return recursionVerify(A?.left, B?.left) && recursionVerify(A?.right, B?.right);
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_11"
    }

}

