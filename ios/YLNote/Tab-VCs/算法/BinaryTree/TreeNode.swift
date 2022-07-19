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

//public class TreeNodeType {
////    public var val: Int
////    public var left: T?
////    public var right: T?
////    public var next:
////    public init(_ val: Int) {
////        self.val = val
////        self.left = nil
////        self.right = nil
////    }
////
//    static func from(_ arr:[Int?],_ index: Int) -> T? {
//        var root:TreeNodeType = nil
//        if index < arr.count {
//            guard let val:Int = arr[index] else { return nil }
//            root = Node(val)
//            root?.left = from(arr, 2*index+1) as? T
//            root?.right = from(arr, 2*index+2) as? T
//        }
//        return root
//    }
//
//    
//}




