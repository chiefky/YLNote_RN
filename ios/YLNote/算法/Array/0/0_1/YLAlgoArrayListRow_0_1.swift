//
//  YLAlgoArrayListRow_0_1.swift
//  YLNote
//
//  Created by tangh on 2022/2/17.
//  Copyright © 2022 tangh. All rights reserved.
//

import UIKit
/*
 剑指 Offer 03. 数组中重复的数字
 找出数组中重复的数字。
 在一个长度为 n 的数组 nums 里的所有数字都在 0～n-1 的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。

 示例 1：
 输入：
 [2, 3, 1, 0, 2, 5, 3]
 输出：2 或 3
 
 链接：https://leetcode.cn/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof/
 */
class YLAlgoArrayListRow_0_1: YLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func testMethod_1() {
        let array = [2,3,1,4,2,5,3] // [2,3,1,0,2,5,3]
        let res = method_set(array);
        print("重复元素是：\(res)")
    }

    @objc func testMethod_2() {
        var array = [2,3,1,4,2,5,3] // [2,3,1,0,2,5,3]
        let res = method_swap(&array);
        print("重复元素是：\(res)")
    }

    /// 方法一：利用Set的特性，不含重复元素 【时间复杂度：O(n); 空间复杂度：O(n)】
    /// - Parameter data: 原数组
    /// - Returns: 重复元素
    func method_set(_ nums:[Int]) -> Int {
        var set:Set<Int> = []
        for num in nums {
            if set.contains(num) {
                return num
            } else {
                set.insert(num)
            }
        }
        return -1
    }
    
    /// 方法二：原地交换 【时间复杂度：O(n); 空间复杂度：O(1)】
    /// - Parameter nums: 原数组
    /// - Returns: 重复元素
    func method_swap(_ nums: inout [Int]) -> Int {
        var i = 0
        while i < nums.count {
            if i == nums[i] {
                i += 1
                continue;
            }
            if nums[i] == nums[nums[i]] {
                return nums[i]
            }
            print("🌹：\(nums)")
            nums.swapAt(i, nums[i])
            print("🌸：\(nums)")
        }
        return -1
    }
    
    //    MARK: override
    override func fileName() -> String {
        return "Algo_array_row_0_1"
    }
}
