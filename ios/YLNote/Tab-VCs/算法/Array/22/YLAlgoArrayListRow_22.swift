//
//  YLAlgoArrayListRow_22.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 29. 顺时针打印矩阵
 输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。

 示例 1：
 输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
 输出：[1,2,3,6,9,8,7,4,5]
 
 示例 2：
 输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
 输出：[1,2,3,4,8,12,11,10,9,5,6,7]

 限制：
 0 <= matrix.length <= 100
 0 <= matrix[i].length <= 100
 
 链接：https://leetcode.cn/problems/shun-shi-zhen-da-yin-ju-zhen-lcof/
 */
class YLAlgoArrayListRow_22: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let arr = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15]]

        let res = spiralOrder(arr)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度 O(m*n）
    /// 空间复杂度O(1)
    ///
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 1, let first = matrix.first else { return matrix.first ?? [] }
        let rows = matrix.count ,columns = first.count
        var res:[Int] = []
        var top = 0, bottom = rows-1, left = 0 ,right = columns-1
        while true {
            // 从左到右
            for i in left...right {
                res.append(matrix[top][i])
            }
            if top+1 > bottom { break }
            top += 1         // 每条路线走完之后，要修改下一条路线的临界点
            
            // 从上到下
            for i in top...bottom {
                res.append(matrix[i][right])
            }
            if right-1 < left { break }
            right -= 1
            
            // 从右到左
            for i in (left...right).reversed() {
                res.append(matrix[bottom][i])
            }
            if bottom-1 < top  { break }
            bottom -= 1

            // 从下到上
            for i in (top...bottom).reversed() {
                res.append(matrix[i][left])
            }
            if left+1 > right { break }
            left += 1
        }

        return res
    }
    
   

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_22"
    }
    
}
