//
//  YLAlgoRecursiveListTest.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 13. 机器人的运动范围
 
 地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外），也不能进入行坐标和列坐标的数位之和大于k的格子。例如，当k为18时，机器人能够进入方格 [35, 37] ，因为3+5+3+7=18。但它不能进入方格 [35, 38]，因为3+5+3+8=19。请问该机器人能够到达多少个格子？

 https://leetcode.cn/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof/description/
 */
class YLAlgoRecursiveListTest: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func recursive_robot() {
     
    }
    
    /// 递归
    /// 该算法使用深度优先搜索（DFS）来遍历所有能够到达的格子，并且利用一个二维数组 visited 来记录每个格子是否已经被访问过。在 DFS 的过程中，如果当前格子超出了边界、它的数位之和大于给定的值 k，或者已经被访问过，就将其视为不可达，返回 0。否则，标记当前格子为已访问，并且继续搜索上下左右四个方向的格子，每次遍历到一个新的合法格子，将答案加一。
    /// 时间复杂度：O(mn)，其中 m 和 n 分别是矩阵的行数和列数。矩阵中的每个格子最多只会被访问一次。
    /// 空间复杂度：O(mn)，其中 m 和 n 分别是矩阵的行数和列数。需要一个大小为 m×n 的二维数组记录每个格子是否已经被访问过。
    func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int {
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        return dfs(0, 0, m, n, k, &visited)
    }

    func dfs(_ i: Int,_ j: Int,_ m: Int, _ n: Int,_ k: Int,_ visited: inout [[Bool]]) -> Int {
        if (i < 0 || i >= m || j < 0 || j >= n || (i%10 + i/10 + j%10 + j/10)>k || visited[i][j]) {
            return 0
        }
        visited[i][j] = true;
        return 1 + dfs(i, j+1, m, n, k, &visited)
        + dfs(i, j-1, m, n, k, &visited)
        + dfs(i+1, j, m, n, k, &visited)
        + dfs(i-1, j, m, n, k, &visited);
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_recursive_test"
    }
    
}
