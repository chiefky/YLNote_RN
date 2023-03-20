//
//  day_test_tree.swift
//  YLNote
//
//  Created by tangh on 2022/10/11.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation
import UIKit

/// 合并二叉树（递归）
/// - Parameters:
///   - r1: tree1 root
///   - r2: tree2 root
/// - Returns: tree
func tree_qes_2_recursion(_ r1:TreeNode? , _ r2:TreeNode?) -> TreeNode? {
    guard let r1 = r1,let r2 = r2 else { return r1 ?? r2 }
    let r = TreeNode(r1.val + r2.val)
    r.left = tree_qes_2_recursion(r1.left, r2.left)
    r.right = tree_qes_2_recursion(r1.right, r2.right)
    return r
}

/// 合并二叉树（迭代）
/// - Parameters:
///   - r1: tree1 root
///   - r2: tree2 root
/// - Returns: tree
func tree_qes_2_iteration(_ r1:TreeNode? , _ r2:TreeNode?) -> TreeNode? {
    guard let root1 = r1,let root2 = r2 else { return r1 ?? r2 }
    var queue:[TreeNode] = [root1,root2]
    while !queue.isEmpty {
        let n1 = queue.removeFirst()
        let n2 = queue.removeFirst()
        n1.val = n1.val + n2.val
        if n1.left != nil,n2.left != nil {
            queue.append(n1.left!)
            queue.append(n2.left!)
        } else if n1.left == nil {
            n1.left = n2.left
        }
        
        if n1.right != nil,n2.right != nil {
            queue.append(n1.right!)
            queue.append(n2.right!)
        } else if n1.right == nil {
            n1.right = n2.right
        }
    }
    return root1
}

/// 填充每个节点的下一个右侧节点指针(迭代）
/// - Parameter root: root
/// - Returns: root
func tree_qes_3_iteration(_ root: Node?) -> Node? {
    var pre = root
    while pre?.left != nil {
        var tmp = pre
        while tmp != nil {
            tmp?.left?.next = tmp?.right
            if tmp?.next != nil {
                tmp?.right?.next = tmp?.next?.left
            }
            tmp = tmp?.next
        }
        
        pre = pre?.left
    }
    return root
}

/// 填充每个节点的下一个右侧节点指针(递归）
/// - Parameter root: <#root description#>
/// - Returns: <#description#>
func tree_qes_3_recusion(_ root: Node?) -> Node? {
    guard let root = root else {
        return nil
    }
    var left = root.left, right = root.right
    while left != nil {
        left?.next = right
        left = left?.right
        right = right?.left
    }
    _ = tree_qes_3_recusion(root.left)
    _ = tree_qes_3_recusion(root.right)
    return root;
}

/// 是否是轴对称二叉树
/// - Parameter root: root
/// - Returns: bool
func tree_qes_4_recusion(_ root: TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    return dfs_qes_4(root.left,root.right);
}

func dfs_qes_4(_ left: TreeNode?,_ right: TreeNode?) -> Bool {
    
    if left == nil,right == nil {
        return true
    } else if left == nil || right == nil {
        return false
    } else if  left?.val != right?.val {
        return false
    }
    
    return dfs_qes_4(left?.left, right?.right) && dfs_qes_4(left?.right, right?.left)
}

/// 重建二叉树
/// - Parameters:
///   - preorder: pre
///   - inorder: in
/// - Returns: root
func tree_qes_6_recusion(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    guard let rootValue = preorder.first,let left_count = inorder.firstIndex(of: rootValue) else {
        return nil
    }
    if left_count > 0 {
        // 有左子树
        let left_preorder = Array(preorder[1...left_count])
        let left_indorder = Array(inorder[0..<left_count])
        let right_preorder = Array(preorder[left_count+1..<preorder.endIndex])
        let right_inorder = Array(inorder[left_count+1..<inorder.endIndex])
        let root = TreeNode(rootValue)
        root.left = tree_qes_6_recusion(left_preorder, left_indorder)
        root.right = tree_qes_6_recusion(right_preorder, right_inorder)
        return root
    } else {
        // 无左子树

        if  preorder.count == 1 {
            // 无右子树
            return TreeNode(rootValue)
        } else {
            // 有右子树
            let root = TreeNode(rootValue)
            let right_preorder = Array(preorder[1..<preorder.endIndex])
            let right_inorder = Array(inorder[1..<inorder.endIndex])
            root.right = tree_qes_6_recusion(right_preorder, right_inorder)
            return root
        }
    }
}

func tree_qes_6_recusion2(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    guard preorder.count > 1,let rootValue = preorder.first else {
        return preorder.first != nil ? TreeNode(preorder[0]) : nil
    }
    let root = TreeNode(rootValue)
    if let left_count = inorder.firstIndex(of: rootValue) {
        if left_count == 0 {
            // 左子树为空
            let right_preorder = Array(preorder[1...])
            let right_inorder = Array(inorder[1...])
            root.right = tree_qes_6_recusion(right_preorder, right_inorder)
            return root
        } else if left_count == preorder.count - 1 {
            // 右子树为空
            let left_preorder = Array(preorder[1...left_count])
            let left_indorder = Array(inorder[0..<left_count])
            root.left = tree_qes_6_recusion(left_preorder, left_indorder)
            return root;
        } else {
            // 左右子树都不为空
            let left_preorder = Array(preorder[1...left_count])
            let left_indorder = Array(inorder[0..<left_count])
            let right_preorder = Array(preorder[left_count+1..<preorder.endIndex])
            let right_inorder = Array(inorder[left_count+1..<inorder.endIndex])
            root.left = tree_qes_6_recusion(left_preorder, left_indorder)
            root.right = tree_qes_6_recusion(right_preorder, right_inorder)
            return root;
        }
    }
    
    return nil
}

func dfs_qes_6(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    guard let rootValue = preorder.first,let left_count = inorder.firstIndex(of: rootValue) else {
        return nil
    }
    if left_count > 0 {
        let left_preorder = Array(preorder[1...left_count])
        let left_indorder = Array(inorder[0..<left_count])
        let right_preorder = Array(preorder[left_count+1..<preorder.endIndex])
        let right_inorder = Array(inorder[left_count+1..<inorder.endIndex])
        let root = TreeNode(rootValue)
        root.left = tree_qes_6_recusion(left_preorder, left_indorder)
        root.right = tree_qes_6_recusion(right_preorder, right_inorder)
        return root
    } else {
        return TreeNode(rootValue)
    }
    
}

/// 从上往下打印二叉树
/// - Parameter root: 根节点
/// - Returns: 一维数组
func tree_qes_8_print_0(_ root: TreeNode?) -> [Int] {
    guard let root = root else {
        return []
    }
    var res:[Int] = []
    var queue:[TreeNode] = [root]
    while !queue.isEmpty {
        var level_count = queue.count
        while level_count > 0 {
            let node = queue.removeFirst()
            res.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
            level_count -= 1
        }
    }
    return res;
}

func tree_qes_7(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else {
        return nil
    }
    let tmp_left = tree_qes_7(root.left)
    let tmp_right = tree_qes_7(root.right)
    root.left = tmp_right
    root.right = tmp_left
    return root
}

/// 从上往下打印二叉树
/// - Parameter root: 根节点
/// - Returns: 二维数组
func tree_qes_8_print_1(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else {
        return []
    }
    var queue:[TreeNode] = [root]
    var res:[[Int]] = []
    while !queue.isEmpty {
        var level_nodes_count = queue.count
        var level_nodes:[Int] = []
        while level_nodes_count > 0 {
            let node = queue.removeFirst()
            level_nodes.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
            level_nodes_count -= 1
        }
        res.append(level_nodes)
    }
    return res;
}

/// 从上往下打印二叉树 (S型打印)
/// - Parameter root: 根节点
/// - Returns: 二维数组
func tree_qes_8_print_2(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else {
        return []
    }
    var level = 0
    var queue:[TreeNode] = [root]
    var res:[[Int]] = []
    while !queue.isEmpty {
        var level_nodes:[Int] = []
        var level_count = queue.count
        while level_count > 0 {
            let node = queue.removeFirst()
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }

            if level%2 == 1 {
                level_nodes.insert(node.val, at: 0)
            } else {
                level_nodes.append(node.val)
            }
            level_count -= 1
        }
        res.append(level_nodes)
        level += 1
    }
    return res;
}

/// 查找公共祖先（二叉搜索树-迭代）
/// - Parameters:
///   - root: <#root description#>
///   - p: <#p description#>
///   - q: <#q description#>
/// - Returns: <#description#>
func tree_qes_9_1(_ root: TreeNode?,_ p: TreeNode?,_ q:TreeNode?) -> TreeNode? {
    guard let root = root ,let n1 = p,let n2 = q else {
        return nil
    }
    var currrent:TreeNode? = root
    while let cur = currrent {
        if cur.val > n1.val && cur.val > n2.val {
            currrent = currrent?.left
        } else if cur.val < n1.val && cur.val < n2.val {
            currrent = currrent?.right
        } else {
            return cur;
        }
    }
    return currrent
}

/// 查找公共祖先（二叉搜索树-递归）
/// - Parameters:
///   - root: <#root description#>
///   - p: <#p description#>
///   - q: <#q description#>
/// - Returns: <#description#>

func tree_qes_9_1_recursion(_ root: TreeNode?,_ p: TreeNode?,_ q:TreeNode?) -> TreeNode? {
    guard let root = root ,let n1 = p,let n2 = q else {
        return nil
    }
    if root.val > n1.val && root.val > n2.val {
        return tree_qes_9_1_recursion(root.left, n1, n2)
    } else if root.val < n1.val && root.val < n2.val {
        return tree_qes_9_1_recursion(root.right, n1, n2)
    } else {
        return root;
    }
}


/// 普通二叉树公共祖先
/// - Parameters:
///   - root: <#root description#>
///   - p: <#p description#>
///   - q: <#q description#>
/// - Returns: <#description#>
func tree_qes_9_2_recursion(_ root: TreeNode?,_ p: TreeNode?,_ q:TreeNode?) -> TreeNode? {
    guard let root = root,let n1 = p,let n2 = q else {
        return nil
    }
    if n1.val == root.val || n2.val == root.val {
        return root
    }

    let l = tree_qes_9_2_recursion(root.left, p, q);
    let r = tree_qes_9_2_recursion(root.right, p, q);
    return l == nil ? r : (r == nil ? l : root)
  
}

//MARK: test
func testTree() {
    let t = TreeNode.from([3,9,20,nil,nil,15,7], 0)
    let res = isBalanced(t)
    print("🌹：\(res)")

}
func isSymmetric(_ root: TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    return dfs_check(root.left, root.right)
}

func dfs_check(_ left:TreeNode?,_ right: TreeNode?) -> Bool {
    if left == nil && right == nil {
        return true
    } else if left == nil || right == nil {
        return false;
    } else {
       return left?.val == right?.val && dfs_check(left?.left, right?.right) && dfs_check(left?.right, right?.left)
    }
}

func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
    var root:TreeNode? = nil
    if let root1 = root1 {
        if let root2 = root2 {
            root = TreeNode(root1.val+root2.val)
            root?.left = mergeTrees(root1.left, root2.left)
            root?.right = mergeTrees(root1.right, root2.right)
        } else {
            root = root1
        }
    } else {
        if let root2 = root2 {
            root = root2
        } else {
            root = nil
        }
    }
    return root
}

func isBalanced(_ root: TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    let l = depth(root.left)
    let r = depth(root.right)
    return abs(l-r) <= 1 && isBalanced(root.left) && isBalanced(root.right)
}

func depth(_ root:TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    let l = depth(root.left)
    let r = depth(root.right)
    return max(l, r) + 1;
}
