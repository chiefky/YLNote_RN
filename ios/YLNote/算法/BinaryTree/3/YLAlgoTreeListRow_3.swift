//
//  YLAlgoTreeListRow_3.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 - [ ] 填充每个节点的下一个右侧节点指针

 给定一个 完美二叉树 ，其所有叶子节点都在同一层，每个父节点都有两个子节点。二叉树定义如下：

 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }
 填充它的每个 next 指针，让这个指针指向其下一个右侧节点。如果找不到下一个右侧节点，则将 next 指针设置为 NULL。

 初始状态下，所有 next 指针都被设置为 NULL。
 https://leetcode.cn/problems/populating-next-right-pointers-in-each-node/
 */
class YLAlgoTreeListRow_3: YLBaseTableViewController {
   
    func from(_ arr:[Int?],_ index: Int) -> Node? {
        var root:Node? = nil
        if index < arr.count {
            guard let val:Int = arr[index] else { return nil }
            root = Node(val)
            root?.left = from(arr, 2*index+1)
            root?.right = from(arr, 2*index+2)
        }
        return root
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let root = from([1,2,3,4,5,6,7], 0);
        let root1 = method_1(root)
        
        var str = String(root1?.val ?? -1) + "#"
        var left = root1?.left
        
        while left != nil {
            str += String(left?.val ?? -1)
            var next = left?.next
            while next != nil  {
                str += String(next?.val ?? -1)
                next = next?.next
            }
            str += "#"
            left = left?.left
        }
        
        print("\(str)");

    }

    @objc func testMethod_2() {
        let root = from([1,2,3,4,5,6,7], 0);
        let root1 = method_2(root)
        
        var str = String(root1?.val ?? -1) + "#"
        var left = root1?.left
        
        while left != nil {
            str += String(left?.val ?? -1)
            var next = left?.next
            while next != nil  {
                str += String(next?.val ?? -1)
                next = next?.next
            }
            str += "#"
            left = left?.left
        }
        
        print("\(str)");

    }
    
    /// 递归 时间复杂度：O(n)，空间复杂度：O(h)； h: 二叉树深度
    /// - Parameter root:
    /// - Returns: <#description#>
    func method_1(_ root:Node?) -> Node? {
        guard let r = root else { return nil }
        var left = r.left,right = r.right
        while left != nil {
            left?.next = right
            left = left?.right;
            right = right?.left;
        }
        
        _ = method_1(r.left)
        _ = method_1(r.right)
        return r
    }
    
    
    /// 迭代 时间复杂度：O(n)，空间复杂度：O(1)
    /// - Parameter root: <#root description#>
    /// - Returns: <#description#>
    func method_2(_ root: Node?) -> Node? {
        guard let r = root else { return nil }
        var father:Node? = r
        while father?.left != nil {
            var tmp:Node? = father
            while tmp != nil {
                tmp!.left?.next = tmp!.right
                if tmp!.next != nil {
                    tmp!.right?.next = tmp!.next?.left
                }
                tmp = tmp?.next
            }
            father = father?.left
        }
        return r
    }
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_3"
    }



}

