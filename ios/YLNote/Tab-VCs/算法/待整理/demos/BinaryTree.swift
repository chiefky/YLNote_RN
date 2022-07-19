//
//  BinaryTree.swift
//  YLNote
//
//  Created by tangh on 2021/1/4.
//  Copyright © 2021 tangh. All rights reserved.
//

import Foundation
class BinaryTreeNode {
    var val: Int
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    init(val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    static func createTree(values:NSArray) -> BinaryTreeNode? {
        var node:BinaryTreeNode?
        for val in values {
            if let val = val as? Int {
                node = BinaryTreeNode.addTreeNode(to: node, value: val)
            }
        }
        print("\(String(describing: node))")
        return node;
        
    }

     static func addTreeNode(to node:BinaryTreeNode?, value: Int) -> BinaryTreeNode {
        if let node = node {
            if value < node.val {
                node.left = BinaryTreeNode.addTreeNode(to: node.left, value: value)
            } else {
                node.right = BinaryTreeNode.addTreeNode(to: node.right, value: value)
            }
            print("\(String(describing: node))")
            return node;
        } else {
            print("init node \(value)")
           return BinaryTreeNode(val: value)
        }
    }

}
