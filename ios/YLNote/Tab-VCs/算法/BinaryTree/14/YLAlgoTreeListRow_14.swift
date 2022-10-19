//
//  YLAlgoTreeListRow_14.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 36. 二叉搜索树与双向链表
 输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的循环双向链表。要求不能创建任何新的节点，只能调整树中节点指针的指向。
 链接：https://leetcode.cn/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/?favorite=xb9nqhhg
 */
class YLAlgoTreeListRow_14: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: 序列化
    @objc func testMethod_serialize() {
        let A = TreeNode.from([1,2,3,nil,nil,4,5],0)
        let res = serialize(A)
        print("🌲serialize：\(res)");
    }
    
    func serialize(_ root:TreeNode?) -> String {
        guard let root = root else {
            return "[]"
        }
        var res = "["
        dfs_pre_serialize(root, &res)
        res.removeLast()
        res += "]"
        return res
    }
    
    /// 递归，先序遍历解析root
    /// - Parameter root: 当前节点
    func dfs_pre_serialize(_ root:TreeNode?, _ str:inout String) {
        guard let root = root else {
            str += "null,"
            return
        }
        str += "\(root.val),"
        dfs_pre_serialize(root.left,&str)
        dfs_pre_serialize(root.right,&str)
    }
    
    
    // MARK: 反序列化
    @objc func testMethod_deserialize() {
        let str = "[1,2,null,null,3,4,null,null,5,null,null]"
        let res = deserialize(str)
        print("🌲deserialize：\(res)");

    }
    func deserialize(_ str:String?) -> TreeNode? {
        guard var s = str ,s.count > 2 else {
            return nil
        }
        s.removeFirst()
        s.removeLast()
        var nodes:[String] = s.components(separatedBy: ",")
        let root = dfs_pre_deserialize(&nodes)
        return root
    }
    
    /// 递归，先序遍历构建root
    /// - Parameter nodes: 剩余待构建节点数组
    /// - Returns: 当前节点
    func dfs_pre_deserialize(_ nodes:inout [String]) -> TreeNode? {
        let first = nodes.removeFirst()
        guard first != "null",let val = Int(first) else { return nil }
        let root = TreeNode(val)
        root.left = dfs_pre_deserialize(&nodes)
        root.right = dfs_pre_deserialize(&nodes)
        return root
    }
    

    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_14"
    }

}

