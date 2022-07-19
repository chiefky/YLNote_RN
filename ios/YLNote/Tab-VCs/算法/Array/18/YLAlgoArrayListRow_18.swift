//
//  YLAlgoArrayListRow_18.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 二维数组中的查找
 在一个 n * m 的二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个高效的函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
 
 示例:
 
 现有矩阵 matrix 如下：
 [
 [1,   4,  7, 11, 15],
 [2,   5,  8, 12, 19],
 [3,   6,  9, 16, 22],
 [10, 13, 14, 17, 24],
 [18, 21, 23, 26, 30]
 ]
 给定 target = 5，返回 true。
 给定 target = 20，返回 false。
 
 链接：https://leetcode.cn/problems/er-wei-shu-zu-zhong-de-cha-zhao-lcof
 */

class YLAlgoArrayListRow_18: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [
            [1,   4,  7, 11, 15],
            [2,   5,  8, 12, 19],
            [3,   6,  9, 16, 22],
            [10, 13, 14, 17, 24],
            [18, 21, 23, 26, 30]
        ]
        let res = findNumberIn2DArray(array, 5)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度 O(M+N)O(M+N) ：其中，NN 和 MM 分别为矩阵行数和列数，此算法最多循环 M+N 次。
    /// 空间复杂度 O(1) : i, j 指针使用常数大小额外空间
    /// - Parameters:
    ///   - matrix: 二维数组
    ///   - target: target
    /// - Returns: bool
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard let first = matrix.first else {
            return false
        }
        var row = 0, column = first.count - 1
        while row < matrix.count , column >= 0 {
            print("🌹 \(row),\(column):\(matrix[row][column])")
            if matrix[row][column] < target {
                row += 1
            } else if matrix[row][column] > target {
                column -= 1
            }  else {
                return true
            }
        }
        
        return false
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_18"
    }
    
}
