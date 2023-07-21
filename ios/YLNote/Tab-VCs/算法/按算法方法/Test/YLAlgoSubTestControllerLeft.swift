//
//  YLAlgoSubTestControllerLeft.swift
//  YLNote
//
//  Created by tangh on 2023/7/7.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit

class YLAlgoSubTestControllerLeft: YLBaseTableViewController {
    
    static var name: String {
        set {
            print("\(newValue)")
        }
        get {
            return "son"
        }
    }
    
    deinit {
        print("\(Self.self) is Deinited")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
    //MARK: 每日抽查测试:
    @objc func DP_test() {
        print("当前函数名：\(#function)")
    }
    
    @objc func backTrack_test(){
        print("当前函数名：\(#function)")
    }
    
    @objc func dfs_test(){
        print("当前函数名：\(#function)")
    }
    
    @objc func bfs_test(){
        print("当前函数名：\(#function)")
    }
    
    @objc func recur_test(){
        print("当前函数名：\(#function)")
    }
    
    @objc func swap_test(){
        print("当前函数名：\(#function)")
    }
    
    //MARK: functions
    
    /// 二叉树深度
    /// - Parameter root: 根节点
    /// - Returns: 树的深度
    func dfs_deepOfBinaryTree(_ root:TreeNode?) -> Int {
        guard let r = root else { return 0 }
        let left_deep = dfs_deepOfBinaryTree(r.left)
        let right_deep = dfs_deepOfBinaryTree(r.right)
        return 1 + max(left_deep, right_deep)
    }
    
    /// 判断平衡二叉树
    /// - Parameter root: 根节点
    /// - Returns: 是否平衡
    func dfs_isBalanced(_ root:TreeNode?) -> Bool {
        guard let root = root else { return true }
        let left_deep = dfs_deepOfBinaryTree(root.left)
        let right_deep = dfs_deepOfBinaryTree(root.right)
        let minus = abs(right_deep-left_deep)
        return minus <= 1 && dfs_isBalanced(root.left) && dfs_isBalanced(root.right)
    }
    
    /// 二叉树的最近公共祖先
    /// - Parameters:
    ///   - root: 根节点
    ///   - p:
    ///   - q:
    /// - Returns: 最近公共祖先
    func dfs_lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root else {return root}
        if p === root || q === root {
            return root
        }
        let left = dfs_lowestCommonAncestor(root.left, p, q)
        let right = dfs_lowestCommonAncestor(root.right, p, q)
        return left == nil ? right : (right==nil ? left : root)
    }
    
    
    //MARK: override
    override func fileName() -> String {
        return "day_test_left"
    }

}
