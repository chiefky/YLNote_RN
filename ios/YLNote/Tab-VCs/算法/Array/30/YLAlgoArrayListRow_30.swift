//
//  YLAlgoArrayListRow_30.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 剑指 Offer 66. 构建乘积数组
 给定一个数组 A[0,1,…,n-1]，请构建一个数组 B[0,1,…,n-1]，其中 B[i] 的值是数组 A 中除了下标 i 以外的元素的积, 即 B[i]=A[0]×A[1]×…×A[i-1]×A[i+1]×…×A[n-1]。不能使用除法。


 示例:
 输入: [1,2,3,4,5]
 输出: [120,60,40,30,24]
  
 提示：
 所有元素乘积之和不会溢出 32 位整数
 a.length <= 100000
 
 https://leetcode.cn/problems/gou-jian-cheng-ji-shu-zu-lcof/
 */
class YLAlgoArrayListRow_30: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @objc func testMethod_1() {
        let nums = [1,2,3,4,5]
        let res = constructArr(nums)
        print("🍎结果：\(res)")
    }
    
    /// 时间复杂度：O(n)，空间复杂度：O(1)
    /// - Parameter a: nums
    /// - Returns: nums
    func constructArr(_ a: [Int]) -> [Int] {
        guard !a.isEmpty else { return [] }
        let length = a.count
        var B:[Int] = Array(repeating: 1, count: length)
        for i in 1...length-1 {
            B[i] = B[i-1] * a[i-1]
        }
        var R = 1
        for j in (0...length-1).reversed() {
            B[j] = B[j] * R
            R = R * a[j]
        }
        return B
    }

    
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_30"
    }
    
}
