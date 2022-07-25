//
//  YLAlgoArrayListRow_6.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/**
 给你一个整数数组nums，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 子数组 是数组中的一个连续部分。

 链接：https://leetcode.cn/problems/maximum-subarray/
 */

class YLAlgoArrayListRow_6: YLBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [-2,1,-3,4,-1,2,1,-5,4]
        let res = method_1(array);
        print("结果：\(res)")
    }

    
    /// 动态规划 最大子数组可以分解成任何一个数组+[当前元素]：只要前一个数组的和+当前元素>当前元素就将当前元素加入前一个数组，否则取当前元素作为新的子数组
    /// 时间复杂度O：(n）,空间复杂度：O(1)
    /// - Parameter nums: 初始数组
    /// - Returns: 最大和
    func method_1(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return (0);
        }
        var preSum = nums[0]
        var maxvalue = nums[0]
        for i in 1..<nums.count {
            preSum = max(preSum+nums[i], nums[i])
            maxvalue = max(preSum, maxvalue)
        }
        return maxvalue
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_6"
    }
    
}
