//
//  YLAlgoDFSListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoDFSListController: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: 剑指 Offer 13. 机器人的运动范围
    // (https://leetcode.cn/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof/description/)
    @objc func dfs_robot() {
        let res = movingCount(3, 4, 3)
        print("\(res)")
    }
    
    /// 递归
    /// 该算法使用深度优先搜索（DFS）来遍历所有能够到达的格子，并且利用一个二维数组 visited 来记录每个格子是否已经被访问过。在 DFS 的过程中，如果当前格子超出了边界、它的数位之和大于给定的值 k，或者已经被访问过，就将其视为不可达，返回 0。否则，标记当前格子为已访问，并且继续搜索上下左右四个方向的格子，每次遍历到一个新的合法格子，将答案加一。
    /// 时间复杂度：O(mn)，其中 m 和 n 分别是矩阵的行数和列数。矩阵中的每个格子最多只会被访问一次。
    /// 空间复杂度：O(mn)，其中 m 和 n 分别是矩阵的行数和列数。需要一个大小为 m×n 的二维数组记录每个格子是否已经被访问过。
    func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int {
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        return moving_core(0, 0, m, n, k, &visited)
    }
    
    func moving_core(_ i: Int,_ j: Int,_ m: Int, _ n: Int,_ k: Int,_ visited: inout [[Bool]]) -> Int {
        if (i < 0 || i >= m || j < 0 || j >= n || (i%10 + i/10 + j%10 + j/10)>k || visited[i][j]) {
            return 0
        }
        visited[i][j] = true;
        return 1 + moving_core(i, j+1, m, n, k, &visited)
        + moving_core(i, j-1, m, n, k, &visited)
        + moving_core(i+1, j, m, n, k, &visited)
        + moving_core(i-1, j, m, n, k, &visited);
    }
    
    //    MARK: 剑指 Offer 26. 树的子结构
    @objc func dfs_isSubStructure()  {
        let A = [3,4,5,1,2], B = [4,1]
        let rootA = TreeNode.from(A, 0)
        let rootB = TreeNode.from(B, 0)
        let res = isSubStructure(rootA, rootB)
        print("B是A的子树？：\(res)");
    }
    func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        guard let A = A,let B = B else { return false }
        return isSub_core(A, B) || isSub_core(A.left, B) || isSub_core(A.right, B);
    }
    func isSub_core(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        if B == nil { return true}
        if A == nil || A?.val != B?.val { return false}
        return isSub_core(A?.left, B?.left) && isSub_core(A?.right, B?.right)
    }
    //    MARK: 剑指 Offer 27. 二叉树的镜像
    @objc func dfs_mirrorTree() {
        let A = [3,4,5,1,2]
        let rootA = TreeNode.from(A, 0)
        let mirror = mirrorTree(rootA)
        let res = mirror == nil ? [0] : mirror!.treeDiscription()
        print("镜像树：\(res)");
        
    }
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        return mirror_core(root)
    }
    func mirror_core(_ root:TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        let left = mirror_core(root.left)
        let right = mirrorTree(root.right)
        root.left = right;
        root.right = left;
        return root
    }
    //    MARK: 剑指 Offer 28. 对称的二叉树
    @objc func dfs_isSymmetric() {
        let A = [1,2,2,3,4,4,3]
        let rootA = TreeNode.from(A, 0)
        let res = isSymmetric(rootA)
        print("是否是对称二叉树：\(res)");
    }
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        return symmetri_core(root.left, root.right);
    }
    func symmetri_core(_ left: TreeNode?,_ right: TreeNode?) -> Bool {
        guard let left = left,let right = right else { return left === right }
        if left.val != right.val {return false}
        let e1 = symmetri_core(left.left, right.right);
        let e2 = symmetri_core(left.right, right.left)
        return e1 && e2
    }
    //    MARK: 6. 剑指 Offer 36. 二叉搜索树与双向链表
    @objc func dfs_treeToDoublyList() {
        let A = [4,2,5,1,3]
        let rootA = TreeNode.from(A, 0)
        let head = treeToDoublyList(rootA)
        let res = head != nil ? String(head!.val) : "空"
        print("二叉搜索树转双向链表,头结点：\(res)");
    }
    var head:TreeNode? = nil
    var pre:TreeNode? = nil
    func treeToDoublyList(_ root:TreeNode?) -> TreeNode? {
        guard let r = root else { return nil }
        treeToDoublyList_core(r)
        pre?.right = head;
        head?.left = pre
        return head
        
    }
    func treeToDoublyList_core(_ root:TreeNode?) {
        guard let r = root else { return }
        treeToDoublyList_core(r.left)
        if pre != nil {
            pre?.right = r
        } else {
            head = r
        }
        r.left = pre;
        pre = r
        treeToDoublyList_core(r.right)
    }
    //    MARK: 剑指 Offer 37. 序列化(反序列化)二叉树
    @objc func dfs_serialize() {
        let A = [4,2,5,1,3]
        let rootA = TreeNode.from(A, 0)
        let res = serialize(rootA)
        print("序列化结果：\(res)")
    }
    
    @objc func dfs_deserialize() {
        let A = [4,2,5,1,3]
        let rootA = TreeNode.from(A, 0)
        let str = serialize(rootA)
        let root = deserialize(str)
        let res = root != nil ? root?.treeDiscription() : [0]
        print("反序列化结果：\(String(describing: res))")
    }
    
    /// 序列化（前序遍历）
    /// - Parameter root: 根节点
    /// - Returns: 🌰："4,2,1,nil,nil,3,nil,nil,5"
    func serialize(_ root: TreeNode?) -> String {
        var str = ""
        serialize_core(root,&str);
        str.removeLast(); // 删除最末尾‘,’
        return str
    }
    /// DFS+前序遍历
    /// 时间复杂度：O(n);空间复杂度：O(n）
    ///考虑递归使用的栈空间的大小，这里栈空间的使用和递归深度有关，递归深度又和二叉树的深度有关，在最差情况下，二叉树退化成一条链，故这里的渐进空间复杂度为 O(n)。
    func serialize_core(_ root:TreeNode?,_ result: inout String) {
        guard let root = root else {
            result += "nil,"
            return
        }
        result += String(root.val) + ","
        serialize_core(root.left,&result)
        serialize_core(root.right,&result)
    }
    
    /// 反序列化
    /// - Parameter data: （前序遍历的结果）🌰："4,2,1,nil,nil,3,nil,nil,5"
    /// - Returns: 根节点
    func deserialize(_ data: String) -> TreeNode? {
        let dataArr:[String] = data.components(separatedBy: ",")
        var index = 0
        let root = deserialize_core(dataArr,&index)
        return root
    }
    
    /// DFS+前序遍历
    /// 时间复杂度：O(n);空间复杂度：O(n）
    ///考虑递归使用的栈空间的大小，这里栈空间的使用和递归深度有关，递归深度又和二叉树的深度有关，在最差情况下，二叉树退化成一条链，故这里的渐进空间复杂度为 O(n)。
    func deserialize_core(_ datas: [String],_ index:inout Int) -> TreeNode? {
        if index >= datas.count {
            return nil
        }
        if datas[index] == "nil" {
            index += 1
            return nil
        }
        
        let val: Int = Int(datas[index])!
        let root = TreeNode(val)
        index += 1;
        root.left = deserialize_core(datas,&index)
        root.right = deserialize_core(datas,&index)
        return root
    }
    
    //    MARK: 8. 剑指 Offer 54. 二叉搜索树的第k大节点
    @objc func dfs_kthLargest() {
        let A = "3,1,4,nil,2"
        let root = TreeNode.buildBinaryTree(A)
        let res = kthLargest(root, 1)
        print("\(res)")
    }
    var res:Int = 0
    func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        guard let root = root else { return 0 }
        var index = 0
        kthLargest_core(root, k, &index)
        return res
    }
    func kthLargest_core(_ root: TreeNode?,_ k:Int,_ index: inout Int)  {
        if let root = root {
            kthLargest_core(root.right, k, &index)
            index += 1;
            if index > k {
                return;
            } else if index == k {
                res = root.val;
                return;
            } else {
                kthLargest_core(root.left, k, &index)
            }
        }
    }
    //    MARK: 9. 剑指 Offer 55 - I. 二叉树的深度
    @objc func dfs_maxDepth() {
        let A = "3,1,4,nil,2"
        let root = TreeNode.buildBinaryTree(A)
        let res = maxDepth(root)
        print("\(res)")
    }
    /// DFS+后序遍历
    ///  时间复杂度：O(n);空间复杂度：O(n)；
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        let left = maxDepth(root.left)
        let right = maxDepth(root.right)
        return 1 + max(left, right)
    }
    
    //    MARK: 10. 剑指 Offer 55 - II. 平衡二叉树
    @objc func dfs_isBalanced() {
        let A = "1,2,2,3,3,null,null,4,4"
        let root = TreeNode.buildBinaryTree(A)
        let res = isBalanced(root)
        print("\(res)")
    }
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        let left = depth_core(root.left)
        let right = depth_core(root.right)
        return abs(left-right) <= 1 && isBalanced(root.left) && isBalanced(root.right);
    }
    func depth_core(_ root:TreeNode?) -> Int {
        guard let root = root else { return 0 }
        let left = depth_core(root.left)
        let right = depth_core(root.right)
        return 1 + max(left, right)
    }
    
    //    MARK: 11. 剑指 Offer 68 - I. 二叉搜索树的最近公共祖先
    @objc func dfs_lowestCommonAncestor() {
        let A = "6,2,8,0,4,7,9,null,null,3,5"
        let root = TreeNode.buildBinaryTree(A)
        let p = root?.left;
        let q = root?.left?.right?.left
        let res = lowestCommonAncestor(root, p, q)
        print("\(res)")
    }
    
    /// 时间复杂度：O(n);空间复杂度：O(n)
    func lowestCommonAncestor(_ root:TreeNode?,_ p:TreeNode?,_ q:TreeNode?) -> TreeNode? {
        guard let root = root,let p = p,let q = q else { return nil }
        if root.val > p.val,root.val > q.val {
            return lowestCommonAncestor(root.left, p, q);
        } else if root.val<p.val,root.val < q.val {
            return lowestCommonAncestor(root.right, p, q)
        } else {
            return root
        }
    }
    
    //    MARK: override
    
    
    // MARK: LeetCode543. 二叉树的直径
    // 链接：https://leetcode.cn/problems/diameter-of-binary-tree/description/?favorite=2cktkvj
    @objc func dfs_diameterOfBinaryTree() {
        let A = "6,2,8,0,4,7,9,null,null,3,5"
        let root = TreeNode.buildBinaryTree(A)
        var res = diameterOfBinaryTree(root);
        print("二叉树的直径：\(res)")
    }
    func diameterOfBinaryTree(_ root:TreeNode?) -> Int {
        var res = 0;
        _ = diameterOfBinaryTree_core(root, &res)
        return res
    }
    /// 深度优先遍历思想，递归实现方案
    /// 时间复杂度：O(n），空间复杂度：O(height)
    func diameterOfBinaryTree_core(_ root:TreeNode?,_ diameter: inout Int) -> Int {
        guard let r = root else { return 0 }
        let left_deep = diameterOfBinaryTree_core(r.left, &diameter)
        let right_deep = diameterOfBinaryTree_core(r.right, &diameter)
        diameter = max(left_deep+right_deep, diameter); //最关键一步，记录遍历过程中半径的最大值
        return 1 + max(left_deep, right_deep)
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_dfs_list"
    }
    
    
}
