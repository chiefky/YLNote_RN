//
//  YLAlgoBackTrackListController.swift
//  YLNote
//
//  Created by tangh on 2022/5/30.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit

class YLAlgoBackTrackListController: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
//   MARK: 剑指 Offer 68 - II. 二叉树的最近公共祖先 (回溯)
    @objc func bt_lowestCommonAncestor() {
        let A = "3,5,1,6,2,0,8,null,null,7,4"
        let root = TreeNode.buildBinaryTree(A)
        let p = root?.left, q = root?.right
        let res = lowestCommonAncestor(root, p, q)
        print("最近公共祖先是：\(res)")
    }
    
    /// 时间复杂度：O(n)；空间复杂度：O(n)
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        if p === root || q === root {
            return root
        }
        let left = lowestCommonAncestor(root.left, p, q)
        let right = lowestCommonAncestor(root.right, p, q)
        
        return left == nil ? right : (right == nil ? left : root)
    }
    //    MARK: 剑指 Offer 34. 二叉树中和为某一值的路径
    @objc func bt_pathSum() {
        let A = [5,4,8,11,nil,13,4,7,2,nil,nil,nil,nil,5,1];
        let rootA = TreeNode.from(A, 0)
        let res = pathSum(rootA, 22)
        print("二叉树中和为某一值的路径：\(res)")
    }
    var allPaths:[[Int]] = []
    var path:[Int] = []
    func pathSum(_ root: TreeNode?, _ target: Int) -> [[Int]] {
        pathSum_dfs(root, target)
        return allPaths
    }
    
    /// 时间复杂度：O(n)；空间复杂度：O(n)
    /// - Parameters:
    ///   - root: <#root description#>
    ///   - target: <#target description#>
    func pathSum_dfs(_ root:TreeNode?,_ target:Int) {
        guard let r = root else { return }
        let t = target - r.val
        path.append(r.val)
        if t == 0 && r.left == nil && r.right == nil {
            allPaths.append(path)
        }
        pathSum_dfs(r.left, t)
        pathSum_dfs(r.right, t)
        path.removeLast()
    }

    // MARK: LeetCode22. 括号生成
    // https://leetcode.cn/problems/generate-parentheses/description/
    @objc func bt_generateParenthesis() {
        let res = generateParenthesis(3)
        print("括号：\(res)")
    }
    
    /// 回溯
    ///
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        
        // 递归函数，生成所有可能的括号组合
        func backtrack(_ s: String, _ left: Int, _ right: Int) {
            if s.count == n * 2 {
                result.append(s)
                return
            }
            if left < n {
                backtrack(s + "(", left + 1, right)
            }
            if right < left {
                backtrack(s + ")", left, right + 1)
            }
        }
        
        backtrack("", 0, 0)
        return result
    }
    
    /// 动态规划
    func dp_generateParenthesis(_ n: Int) -> [String] {
        var dp = [[String]](repeating: [], count: n + 1)
        dp[0].append("")
        
        for i in 1...n {
            for j in 0..<i {
                let left = dp[j]
                let right = dp[i - j - 1]
                for l in left {
                    for r in right {
                        dp[i].append("(\(l))\(r)")
                    }
                }
            }
        }
        
        return dp[n]
    }

    //    MARK: override
    override func fileName() -> String {
        return "Algo_backTrack_list"
    }

    
}
