//
//  YLAlgoTreeListRow_0.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoTreeListRow_0: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// 使用递归
    /// - Returns: 深度
    @objc func testBinaryDepthByRecursion() {
        let rootNode = BinaryTreeNode(val: 1)
        let node1 = BinaryTreeNode(val: 3)
        let node2 = BinaryTreeNode(val: 4)
        let node3 = BinaryTreeNode(val: 5)
        rootNode.left = node1;
        rootNode.right = node2
        node1.left = node3
        node1.right = nil
        node2.left = nil;
        node2.right = nil
        node3.left = nil;
        node3.right = nil;
        let deep = getBinaryTreeDepthByRecursion(rootNode)
        print("二叉树深度:\(deep)")

    }
    
    /// "使用栈+DFS"
    /// - Returns: 深度
    @objc func testBinaryDepthByDFS() {
        let rootNode = BinaryTreeNode(val: 1)
        let node1 = BinaryTreeNode(val: 3)
        let node2 = BinaryTreeNode(val: 4)
        let node3 = BinaryTreeNode(val: 5)
        rootNode.left = node1;
        rootNode.right = node2
        node1.left = node3
        node1.right = nil
        node2.left = nil;
        node2.right = nil
        node3.left = nil;
        node3.right = nil;
        let deep = getBinaryTreeDepthWithDFS(rootNode)
        print("二叉树深度:\(deep)")

    }

    /// "使用队列+BFS"
    /// - Returns: 深度
    @objc func testBinaryDepthByBFS() {
        let rootNode = BinaryTreeNode(val: 1)
        let node1 = BinaryTreeNode(val: 3)
        let node2 = BinaryTreeNode(val: 4)
        let node3 = BinaryTreeNode(val: 5)
        rootNode.left = node1;
        rootNode.right = node2
        node1.left = node3
        node1.right = nil
        node2.left = nil;
        node2.right = nil
        node3.left = nil;
        node3.right = nil;
        let deep = getBinaryTreeDepthWithBFS(rootNode)
        print("二叉树深度:\(deep)")

    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_0"
    }



}

