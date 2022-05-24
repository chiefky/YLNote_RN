//
//  YLAlgoTreeViewContollerRow1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoTreeViewContollerRow1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// 练习三：输入一课二叉树的根结点，判断该树是不是平衡二叉树
    @objc func testIsBalanced() {
        let rootNode = BinaryTreeNode.createTree(values: [5,3,4,6,7])
        let result = isBalancedByRecursion(rootNode)
        print("result: \(result)")
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_1"
    }


}
