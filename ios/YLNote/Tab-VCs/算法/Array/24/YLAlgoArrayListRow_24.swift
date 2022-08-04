//
//  YLAlgoArrayListRow_24.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 53 - II. 0～n-1中缺失的数字
 一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字都在范围0～n-1之内。在范围0～n-1内的n个数字中有且只有一个数字不在该数组中，请找出这个数字。
  
 示例 1:
 输入: [0,1,3]
 输出: 2
 示例 2:
 输入: [0,1,2,3,4,5,6,7,9]
 输出: 8
  
 限制：
 1 <= 数组长度 <= 10000
 https://leetcode.cn/problems/que-shi-de-shu-zi-lcof/
 */
class YLAlgoArrayListRow_24: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let arr = [0,1,3]
        let res = compareIndex(arr)
        print("🍎结果：\(res)")
    }

    @objc func testMethod_2() {
        let arr = [0,1,2,3,4,5,6,7,9]
        let res = binary_compare(arr)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func compareIndex(_ nums:[Int]) -> Int {
        let right = nums.count
        for i in 0...right {
            if i<right,nums[i] != i {
                return i
            }
        }
        return right
    }
    
    /// 时间复杂度：O(logn)，空间复杂度：O(1)
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func binary_compare(_ nums: [Int]) -> Int {
        var left = 0,right = nums.count - 1
        while left <= right {
            let mid = left + (right-left)/2
            if nums[mid] == mid {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return left
    }
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_24"
    }
    
}
