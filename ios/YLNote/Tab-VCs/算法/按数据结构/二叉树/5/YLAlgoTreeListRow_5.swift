//
//  YLAlgoTreeListRow_5.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 543. 二叉树的直径
 给定一棵二叉树，你需要计算它的直径长度。一棵二叉树的直径长度是任意两个结点路径长度中的最大值。这条路径可能穿过也可能不穿过根结点。
 https://leetcode.cn/problems/diameter-of-binary-tree/description/?favorite=2cktkvj
 */
class YLAlgoTreeListRow_5: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let root = TreeNode.from([1,2,3,4,5], 0);
        let res = method_1(root)
        
        print("\(res)");

    }


    /// 递归 时间复杂度：O(n)，空间复杂度：O(h)； h: 二叉树深度
    var maxRad = 0
    func method_1(_ root: TreeNode?) -> Int {
//        guard let r = root else { return 0 }
        let x = deepth(root)
        return maxRad
    }
    func deepth(_ root: TreeNode?) -> Int {
        guard let r = root else { return 0 }
        let left = method_1(r.left)
        let right = method_1(r.right)
        maxRad = max(maxRad, left+right+1)
        print("🌹\(r.val):\(left+right+1)/\(0)");
        return max(left, right)+1
    }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_5"
    }



}

