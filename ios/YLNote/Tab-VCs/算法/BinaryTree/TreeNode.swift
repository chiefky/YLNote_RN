//
//  YLTreeNode.swift
//  YLNote
//
//  Created by tangh on 2020/7/22.
//  Copyright © 2020 tangh. All rights reserved.
//

import Foundation

public class Node {
    var val: Int
    var left: Node?
    var right: Node?
    public var next: Node?
    init(_ val: Int) {
        self.val = val
    }
    
    static func from(_ arr:[Int?],_ index: Int) -> Node? {
        var root:Node? = nil
        if index < arr.count {
            guard let val:Int = arr[index] else { return nil }
            root = Node(val)
            root?.left = from(arr, 2*index+1)
            root?.right = from(arr, 2*index+2)
        }
        return root
    }

}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    static func from(_ arr:[Int?],_ index: Int) -> TreeNode? {
        var root:TreeNode? = nil
        if index < arr.count {
            guard let val:Int = arr[index] else { return nil }
            root = TreeNode(val)
            root?.left = from(arr, 2*index+1)
            root?.right = from(arr, 2*index+2)
        }
        return root
    }

}


extension TreeNode {
    func treeDiscription() -> [Int] {
        var res:[Int] = []
        var queue:[TreeNode] = [self]
        while !queue.isEmpty {
            var count = queue.count
            while count > 0 {
                let node = queue.removeFirst()
                res.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
                count -= 1
            }
        }
        return res
    }
}


