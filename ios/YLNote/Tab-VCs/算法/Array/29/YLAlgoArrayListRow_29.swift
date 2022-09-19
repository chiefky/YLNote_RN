//
//  YLAlgoArrayListRow_29.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 47. 礼物的最大价值
 在一个 m*n 的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于 0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向右或者向下移动一格、直到到达棋盘的右下角。给定一个棋盘及其上面的礼物的价值，请计算你最多能拿到多少价值的礼物？

 示例 1:
 输入:
 [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 输出: 12
 解释: 路径 1→3→5→2→1 可以拿到最多价值的礼物

 https://leetcode.cn/problems/li-wu-de-zui-da-jie-zhi-lcof/
 */
class YLAlgoArrayListRow_29: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let board:[[Int]] = [
            [1,3,1],
            [1,5,1],
            [4,2,1]
          ]
        let res = ""//maxValue(board);
        print("🍎结果：\(res)")
    }

//    func maxValue(_ grid: [[Int]]) -> Int {
//        guard let first = grid.first else { return 0 }
//        let m = grid.count , n = first.count
//        for i in 0..<m {
//            for j in 0..<n {
//                if i == 0 && j == 0 {
//                    continue;
//                }
//                if i == 0 {
//                    grid[i][j] += grid[i][j-1];
//                }
//            }
//        }
//
//    }
    

    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_29"
    }
    
}
