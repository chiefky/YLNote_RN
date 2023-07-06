//
//  YLAlgoTreeListRow_6.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 07. 重建二叉树
 输入某二叉树的前序遍历和中序遍历的结果，请构建该二叉树并返回其根节点。
 假设输入的前序遍历和中序遍历的结果中都不含重复的数字。

 示例 1:
 Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
 Output: [3,9,20,null,null,15,7]
 示例 2:

 Input: preorder = [-1], inorder = [-1]
 Output: [-1]
 链接：https://leetcode.cn/problems/zhong-jian-er-cha-shu-lcof/
 */
class YLAlgoTreeListRow_6: YLBaseTableViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr1 = [3,9,20,15,7], arr2 = [9,3,15,20,7]
        
        let res = buildTree(arr1, arr2)
        
        print("🌲：\(res)");

    }
        
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard preorder.count > 1 else {
            return !preorder.isEmpty ? TreeNode(preorder[0]) : nil;
        }
        if let rootIndex = inorder.firstIndex(of: preorder[0]) {
            let root = TreeNode(preorder[0]);
            if rootIndex == 0 {
                // 左子树为空
                root.left = nil
                let r_inorder:[Int] = Array(inorder[1...]) // 右子树的中序遍历数组
                let r_preorder:[Int] = Array(preorder[1...]) // 右子树的前序遍历数组
                root.right = buildTree(r_preorder, r_inorder)
            } else if rootIndex == inorder.count - 1 {
                // 右子树为nil
                root.right = nil
                let left_length = rootIndex
                let l_inorder:[Int] = Array(inorder[0..<left_length]) // 左子树的中序遍历数组
                let l_preorder:[Int] = Array(preorder[1...left_length]) // 左子树的前序遍历数组
                root.left = buildTree(l_preorder, l_inorder)
            } else {
                // 左右子树均不为nil
                let left_length = rootIndex
                let l_inorder:[Int] = Array(inorder[0..<left_length]) // 左子树的中序遍历数组
                let l_preorder:[Int] = Array(preorder[1...left_length]) // 左子树的前序遍历数组
                let r_inorder:[Int] = Array(inorder[(rootIndex+1)...]) // 右子树的中序遍历数组
                let r_preorder:[Int] = Array(preorder[(1+left_length)...]) // 右子树的前序遍历数组
                root.left = buildTree(l_preorder, l_inorder)
                root.right = buildTree(r_preorder, r_inorder)
            }
            
            return root;
        }
        return nil
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_tree_row_6"
    }



}

