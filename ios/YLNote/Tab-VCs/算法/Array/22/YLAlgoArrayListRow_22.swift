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

    /// 时间复杂度 O(m*n）; 空间复杂度O(1)
    /// 每遍历一趟，边界往里缩进一层
    func spiralOrder(_ nums: [[Int]]) -> [Int] {
        guard let firstline = nums.first,firstline.count > 0 else { return [] }
        let m = nums.count, n = firstline.count
        var t = 0,l = 0 ,b = m - 1,r = n - 1
        var res:[Int] = []
        while true {
            // t: 左->右,修改上边界
            for i in l...r {
                res.append(nums[t][i])
            }
            if t + 1 > b { break }
            t += 1
            
            // r: 上->下，修改右边界
            for i in t...b {
                res.append(nums[i][r])
            }
            if r-1 < l { break }
            r -= 1

            // b: 右->左，修改下边界
            for i in (l...r).reversed() {
                res.append(nums[b][i])
            }
            if b-1 < t { break }
            b -= 1

            // l: 下->上，修改左边界
            for i in (t...b).reversed() {
                res.append(nums[i][l])
            }
            if l+1 > r { break }
            l += 1
            
        }
        return res
    }
    
    
   

    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_22"
    }
    
}
