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
    
    /// 根据数组构建二叉树
    /// - Parameters:
    ///   - arr: 二叉树的前序遍历的结果（每层nil节点缺一不可）
    ///   - index: 根结点对应数组的下标
    /// - Returns: 二叉树
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
    
    /// 根据数组创建二叉树 （反序列化）
    /// - Parameter str: 层次遍历结果 例："3,1,4,null,2"
    /// - Returns: root
    static func buildBinaryTree(_ str:String) -> TreeNode? {
        var strArr = str.components(separatedBy: ",");
        guard let rootValue = Int(strArr.removeFirst()) else { return nil }
        let root = TreeNode(rootValue)
        var queue:[TreeNode] = [root]
        var isLeftNode = true
        for str in strArr {
            if let nodeValue = Int(str) {
                let node = TreeNode(nodeValue)
                if isLeftNode {
                    queue.first?.left = node;
                } else {
                    queue.first?.right = node;
                }
                queue.append(node)
            }
            
            if !isLeftNode {
                queue.removeFirst();
            }
            isLeftNode = !isLeftNode;
        }
        return root
    }
    
    /// 根据一颗二叉树，输出其层次遍历结果
    /// - Parameter root: root
    /// - Returns: 层次遍历结果 例："3,1,4,null,2"
     func binaryTreeDescription() -> String {
        let root = self
        var queue = [root]
        var res = String(root.val) + ","
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if let left = node.left {
                res += "\(left.val),"
                queue.append(left)
            } else {
                res += "nil,"
            }
            if let right = node.right {
                res += "\(right.val),"
                queue.append(right)
            } else {
                res += "nil,"
            }
        }
        res.removeLast() // 删除最末尾多余的“,”
        return res;
    }
}


extension TreeNode {
    
    /// 层次遍历
    /// - Returns: 节点数组
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


