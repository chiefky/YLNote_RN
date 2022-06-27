//
//  YLAlgoTreeListRow_2.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 
 给你两棵二叉树： root1 和 root2 。
 想象一下，当你将其中一棵覆盖到另一棵之上时，两棵树上的一些节点将会重叠（而另一些不会）。你需要将这两棵树合并成一棵新二叉树。合并的规则是：如果两个节点重叠，那么将这两个节点的值相加作为合并后节点的新值；否则，不为 null 的节点将直接作为新二叉树的节点。
 返回合并后的二叉树。

 注意: 合并过程必须从两个树的根节点开始。
 https://leetcode.cn/problems/merge-two-binary-trees/
 */
class YLAlgoTreeListRow_2: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod() {
        let root1 = TreeNode.from([1,3,2,5], 0);
        let root2 = TreeNode.from([2,1,3,nil,4,nil,7], 0)
        let res = method_1(root1, root2);
        print("\(res)");
        
    }

    
    func method_1(_ root1:TreeNode?, _ root2:TreeNode?) -> TreeNode? {
        guard let r1 = root1,let r2 = root2 else { return root1 ?? root2 }
        
        let root = TreeNode(r1.val + r2.val)
        root.left = method_1(r1.left, r2.left)
        root.right = method_1(r1.right, r2.right)
        return root
    }
    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_2"
    }



}

